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
                // 'driver_id' => null,
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
        $user = Auth::user();

        $driverRequests = DriverRequest::with('user')
            ->where(function($query) use ($user) {
                $query->where('status', '!=', 'Done')
                    ->where(function($query) use ($user) {
                        $query->whereNull('driver_id')
                                ->orWhere('driver_id', $user->id);
                    });
            })->get();

        return response()->json([
            'message' => 'List of all driver requests',
            'driver_request' => $driverRequests
        ], 200);
    }

    public function handleRequest(Request $request, $id)
    {
        $driverRequest = DriverRequest::find($id);
        $request = $request->input('status');
        $user = Auth::user();
    
        if (!$driverRequest) {
            return response()->json([
                'error' => 'Request not found',
            ], 404);
        }

        if($request == 'Approved') {
            $driverRequest->update([
               'status' => 'Approved', 
                'driver_id' => $user->id,
            ]);
        } else {
            $driverRequest->update([
                'status' => $request, 
            ]);
        }
    
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

    public function myRequestStatus()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'message' => 'Unauthorized',
            ], 401);
        }

        $driverRequests = DriverRequest::where('user_id', $user->id)
            ->whereIn('status', ['Approved', 'Pending'])
            ->with('user')
            ->join('users', 'driver_requests.user_id', '=', 'users.id')
            ->orderBy('users.first_name')
            ->get();

        return response()->json([
            'message' => 'List of my request statuses',
            'driver_requests' => $driverRequests
        ], 200);
    }
}
