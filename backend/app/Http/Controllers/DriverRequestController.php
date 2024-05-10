<?php

namespace App\Http\Controllers;

use App\Models\DriverRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DriverRequestController extends Controller
{
    public function driverRequest(Request $request)
    {
        $user = Auth::user();
        
        if ($user) {
            $request = DriverRequest::create([
                'user_id' => $user->id,
                'status' => 'pending',
            ]);
    
            return response()->json([
                'message' => 'Request sent successfully',
                'request' => $request
            ], 200);
        } else {
            return response()->json(['message' => 'Unauthorized'], 401);
        }
    }
}
