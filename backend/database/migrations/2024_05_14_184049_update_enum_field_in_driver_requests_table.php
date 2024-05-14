<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('driver_requests', function (Blueprint $table) {
            DB::statement("ALTER TABLE driver_requests MODIFY status ENUM('Pending', 'Approved', 'Rejected', 'Done')");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('driver_requests', function (Blueprint $table) {
            //
        });
    }
};
