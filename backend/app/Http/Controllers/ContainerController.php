<?php

namespace App\Http\Controllers;

use App\Events\ContainerCapacityExceeded;
use App\Models\Container;
use App\Models\Notification;
use Illuminate\Http\Request;
use App\Notifications\FirebaseNotification;

class ContainerController extends Controller
{
    public function getContainer()
    {
        $containers = Container::with('type')->where('user_id', auth()->id())->get();
        return response()->json(['containers' => $containers]);
    }

    public function show($id)
    {
        $container = Container::findOrFail($id);
        event(new ContainerCapacityExceeded($container));
        return response()->json($container);
    }

    public function store()
    {
        $data = request()->validate([
            'value'=>['required']
        ]);
        $container = Container::where('user_id', 4)->first(); 

        if ($container) {
            $container->capacity = intval($data['value']);
            $container->save();

            if ($data['value'] == 100) {
                Notification::create([
                    'user_id' => $container->user_id,
                    'message' => 'Your plastic container is full! Please request a driver.'
                ]);

                $container->user->notify(new FirebaseNotification("Your plastic container is full! Please request a driver."));
            }

            event(new ContainerCapacityExceeded($container));

            return response()->json(['message' => 'Container capacity updated successfully', 'container' => $container], 200);
        } else {
            return response()->json(['error' => 'Container not found'], 404);
        }
    }

}
