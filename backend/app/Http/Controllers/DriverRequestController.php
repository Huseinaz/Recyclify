<?php

namespace App\Http\Controllers;

use App\Events\DriverRequest as EventsDriverRequest;
use App\Models\DriverRequest;
use App\Models\User;
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

            event(new EventsDriverRequest($driverRequest));
    
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

    public function acceptRequest($id)
    {
        $driverRequest = DriverRequest::find($id);
    
        if (!$driverRequest) {
            return response()->json([
                'error' => 'Request not found',
            ], 404);
        }
    
        if ($driverRequest->status === 'Approved') {
            return response()->json([
                'error' => 'Request has already been approved',
            ], 400);
        }
    
        $driverRequest->update(['status' => 'Approved']);
    
        $user = User::find($driverRequest->user_id);
    
        if (!$user) {
            return response()->json([
                'error' => 'User not found for this request',
            ], 404);
        }
    
        return response()->json([
            'message' => 'Request accepted',
            'driver_request' => $driverRequest,
        ], 200);
    }

    public function rejectRequest($id)
    {
        $driverRequest = DriverRequest::find($id);

        if (!$driverRequest) {
            return response()->json([
                'message' => 'Request not found',
            ], 404);
        }

        $driverRequest->update(['status' => 'Rejected']);

        return response()->json([
            'message' => 'Request rejected',
            'driver_request' => $driverRequest
        ], 200);
    }
}
