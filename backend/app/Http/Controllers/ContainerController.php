<?php

namespace App\Http\Controllers;

use App\Models\Container;
use Illuminate\Http\Request;

class ContainerController extends Controller
{
    public function index()
    {
        $containers = Container::all();
        return response()->json($containers);
    }

    public function show($id)
    {
        $container = Container::findOrFail($id);
        return response()->json($container);
    }
}
