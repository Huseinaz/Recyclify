<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UsersController extends Controller
{
    public function getUser()
    {
        if (!auth()->check()) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        $user_id = auth()->user()->id;
        $user_role = auth()->user()->role_id;

        if ($user_role === 1) {
            $user = User::find($user_id);
            $users = User::all();

            return response()->json([
                'user' => $user,
                'users' => $users
            ]);
        } else {
            $user = User::find($user_id);

            return response()->json([
                'user' => $user
            ]);
        }
    }

    public function activateUser($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $user->active = true;
        $user->save();

        return response()->json(['message' => 'User activated successfully']);
    }
}
