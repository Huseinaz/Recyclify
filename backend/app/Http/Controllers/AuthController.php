<?php

namespace App\Http\Controllers;

use App\Models\Container;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class AuthController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'register']]);
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);
        $credentials = $request->only('email', 'password');

        $token = Auth::attempt($credentials);
        if (!$token) {
            return response()->json([
                'status' => 'error',
                'message' => 'Unauthorized',
            ], 401);
        }

        $user = Auth::user();

        if ($user->active === 0) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }
        
        return response()->json([
            'status' => 'success',
            'user' => $user,
            'authorisation' => [
                'token' => $token,
                'type' => 'bearer',
            ]
        ]);
    }

    public function register(Request $request)
    {
        $request->validate([
            'first_name' => 'required|string|max:255',
            'last_name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6',
            'fcmtoken' => 'required|string|max:255',
            'latitude' => 'nullable|numeric',
            'longitude' => 'nullable|numeric',
        ]);

    DB::beginTransaction();
    try {
        $user = User::create([
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
            'email' => $request->email,
            'password' => $request->password,
            'fcmtoken' => $request->fcmtoken,
            'latitude' => $request->latitude,
            'longitude' => $request->longitude,
        ]);

        $typeIds = [1, 2, 3, 4];
        foreach ($typeIds as $typeId) {
            Container::create([
                'user_id' => $user->id,
                'type_id' => $typeId,
                'capacity' => 0,
            ]);
        }

        DB::commit();

        $token = Auth::login($user);
        return response()->json([
            'status' => 'success',
            'message' => 'User created successfully',
            'user' => $user,
            'authorisation' => [
                'token' => $token,
                'type' => 'bearer',
            ]
        ]);
    } catch (\Exception $e) {
        DB::rollback();
        return response()->json([
            'status' => 'error',
            'message' => 'User registration failed',
            'error' => $e->getMessage(),
        ], 500);
    }
}

    public function createDriver(Request $request)
    {
        $request->validate([
            'first_name' => 'required|string|max:255',
            'last_name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6',
        ]);

        $user = new User();
        $user->first_name = $request->first_name;
        $user->last_name = $request->last_name;
        $user->email = $request->email;
        $user->role_id = 3;
        $user->password = $request->password;
        $user->fcmtoken = 'c4WqGceaQDm7QcVeefz0ux:APA91bEIAoYtGPBZ1z8F-9v-s5s_NPfhCXYF0jzL9uWtAFAR3v0RmwtskUc_iio5rHnvkezdJn2Sht6m5ji0ui8mt8gnE57pqmgjeMOkWYAX-YLwJ4lngQ8WOLecPx9RP3WZ2hK5HIXq';
        $user->save();

        $token = auth()->login($user);

        return response()->json([
            'status' => 'success',
            'message' => 'Driver created successfully',
        ]);
    }

    public function logout()
    {
        Auth::logout();
        return response()->json([
            'status' => 'success',
            'message' => 'Successfully logged out',
        ]);
    }

    public function refresh()
    {
        return response()->json([
            'status' => 'success',
            'user' => Auth::user(),
            'authorisation' => [
                'token' => Auth::refresh(),
                'type' => 'bearer',
            ]
        ]);
    }
}
