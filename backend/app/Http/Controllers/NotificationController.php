<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
class NotificationController extends Controller
{
    public function index()
    {
        $notifications = Notification::all();
        return response()->json($notifications);
    }

    public function show($id)
    {
        $notification = Notification::findOrFail($id);
        return response()->json($notification);
    }

    public function store(Request $request)
    {
        $notificationMessage = $request->input('message');
        
        Notification::create([
            'user_id' => Auth::id(),
            'message' => $notificationMessage,
        ]);
        
        $notifications = Notification::where('user_id', Auth::id())->get();
        
        return response()->json($notifications);
    }
}
