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
            $driverRequest = DriverRequest::create([
                'user_id' => $user->id,
                'status' => 'pending',
            ]);
    
            return response()->json([
                'message' => 'Request sent successfully',
                'driver_request' => $driverRequest
            ], 200);
        } else {
            return response()->json(['message' => 'Unauthorized'], 401);
        }
    }

    public function viewRequests()
    {
        $driverRequests = DriverRequest::with('user')->get();

        return response()->json([
            'message' => 'List of all driver requests',
            'driver_request' => $driverRequests
        ], 200);
    }
}
