<?php

namespace App\Http\Controllers;

use App\Models\Container;
use Illuminate\Http\Request;

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
        return response()->json($container);
    }
}
