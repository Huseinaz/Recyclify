<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ContainerController;
use App\Http\Controllers\UsersController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::controller(AuthController::class)->group(function () {
    Route::post('login', 'login');
    Route::post('register', 'register');
    Route::post('logout', 'logout');
    Route::post('refresh', 'refresh');
});

Route::middleware('admin')->group(function(){
    Route::get('users/get', [UsersController::class, 'getUser']);
    Route::post('users/{id}/activate', [UsersController::class, 'activateUser']);
    Route::post('users/{id}/shutdown', [UsersController::class, 'shutdownUser']);
    Route::delete('users/{id}', [UsersController::class, 'deleteUser']);
    Route::post('createDriver',[AuthController::class, 'createDriver']);
});

Route::middleware('user')->group(function(){
    Route::get('/containers', [ContainerController::class, 'getContainer']);
});