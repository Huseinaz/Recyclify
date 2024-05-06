<?php

namespace Database\Seeders;

use App\Models\Type;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class TypesTableSeeder extends Seeder
{
    public function run(): void
    {
        $type = new Type();
        $type->name = 'Paper';
        $type->save();

        $type = new Type();
        $type->name = 'Glass';
        $type->save();

        $type = new Type();
        $type->name = 'Plastic';
        $type->save();

        $type = new Type();
        $type->name = 'Metal';
        $type->save();
    }
}
