<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ContainerController;
use App\Http\Controllers\DriverRequestController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\UsersController;
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
    Route::get('users', [UsersController::class, 'getUser']);
    Route::get('/profile', [UsersController::class, 'getUserProfile']);
    Route::post('/driverRequest', [DriverRequestController::class, 'driverRequest']);
});

Route::middleware('driver')->group(function(){
    Route::get('users', [UsersController::class, 'getUser']);
    Route::get('/profile', [UsersController::class, 'getUserProfile']);
    Route::post('/viewRequests', [DriverRequestController::class, 'viewRequests']);
    Route::post('driverRequest/{id}/acceptRequest', [DriverRequestController::class, 'acceptRequest']);
    Route::post('driverRequest/{id}/rejectdRequest', [DriverRequestController::class, 'rejectdRequest']);
});

Route::post('/notifications', [NotificationController::class, 'store']);