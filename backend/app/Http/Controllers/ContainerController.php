<?php

namespace App\Http\Controllers;

use App\Events\ContainerCapacityExceeded;
use App\Models\Container;
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
            if($data['value'] == 100){
                $container->user->notify(new FirebaseNotification("Your container is almost full."));
            }
            return response()->json(['message' => 'Container capacity updated successfully', 'container' => $container], 200);
            event(new ContainerCapacityExceeded($container));
        } else {
            return response()->json(['error' => 'Container not found'], 404);
        }
    }

}
