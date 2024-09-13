<?php

namespace Acorn\Finance\Models;

use Acorn\Model;
use Acorn\Models\Server;

/**
 * Currency Model
 */
class Currency extends Model
{
    /* Generated Fields:
     *   symbol(character)
     *   shortname(character)
     *   name(character)
     *   id(uuid)
     */

    use \Illuminate\Database\Eloquent\Concerns\HasUuids;
    use \Winter\Storm\Database\Traits\Revisionable;
    protected $revisionable = [];

    use \Winter\Storm\Database\Traits\Validation;

    /**
     * @var string The database table used by the model.
     */
    public $table = 'acorn_finance_currencies';

    /**
     * @var array Guarded fields
     */
    protected $guarded = ['*'];

    /**
     * @var array Fillable fields
     */
    protected $fillable = [];

    /**
     * @var array Validation rules for attributes
     */
    public $rules = [];

    /**
     * @var array Attributes to be cast to native types
     */
    protected $casts = [];

    /**
     * @var array Attributes to be cast to JSON
     */
    protected $jsonable = [];

    /**
     * @var array Attributes to be appended to the API representation of the model (ex. toArray())
     */
    protected $appends = [];

    /**
     * @var array Attributes to be removed from the API representation of the model (ex. toArray())
     */
    protected $hidden = [];

    /**
     * @var array Attributes to be cast to Argon (Carbon) instances
     */
    public $timestamps = FALSE;
    protected $dates = [
    ];

    /**
     * @var array Relations
     */
    public $hasOne = [];
    public $hasMany = [];
    public $hasOneThrough = [];
    public $hasManyThrough = [];
    public $belongsTo = [
    ];
    public $belongsToMany = [];
    public $morphTo = [];
    public $morphOne = [];
    public $morphMany = [
        'revision_history' => ['System\Models\Revision', 'name' => 'revisionable'],
    ];
    public $attachOne = [];
    public $attachMany = [];

    # Auto-injected by acorn-create-system
    public static function menuitemCount() {return self::all()->count();}
}

// Created By ./acorn-create-system v1.0
