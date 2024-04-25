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
}
