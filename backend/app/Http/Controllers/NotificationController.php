<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
class NotificationController extends Controller
{
    public function getNotification(Request $request)
    {
        $user = Auth::user();
        $notifications = Notification::where('user_id', $user->id)->orderBy('created_at', 'desc')->get();
        return response()->json($notifications);
    }
}
