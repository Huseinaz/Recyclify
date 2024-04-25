<?php

namespace Database\Seeders;

use App\Models\Role;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class UsersTableSeeder extends Seeder
{
    public function run(): void
    {
        $user = new User();
        $user->first_name = 'Hussein';
        $user->last_name = 'Abou Zeinab';
        $user->email = 'hussein@gmail.com';
        $user->password = 'password';
        $user->role_id = Role::where('name', 'Admin')->first()->id;
        $user->save();

        $user = new User();
        $user->first_name = 'Jane';
        $user->last_name = 'Doe';
        $user->email = 'jane@gmail.com';
        $user->password = 'password';
        $user->latitude = 33.888630;
        $user->longitude = 35.495480;
        $user->save();

        $user = new User();
        $user->first_name = 'John';
        $user->last_name = 'Doe';
        $user->email = 'john@gmail.com';
        $user->password = 'password';
        $user->role_id = Role::where('name', 'Driver')->first()->id;
        $user->latitude = 33.851421;
        $user->longitude = 35.528182;
        $user->save();
    }
}
