<?php

namespace App\Http\Controllers;

use App\Models\Type;
use Illuminate\Http\Request;

class TypeController extends Controller
{
    public function index()
    {
        $types = Type::all();
        return response()->json($types);
    }

    public function show($id)
    {
        $type = Type::findOrFail($id);
        return response()->json($type);
    }
}
