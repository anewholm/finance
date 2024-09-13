<?php namespace Acorn\Finance\Controllers;

use BackendMenu;
use Acorn\Controller;

/**
 * Invoices Backend Controller
 */
class Invoices extends Controller
{
    /**
     * @var array Behaviors that are implemented by this controller.
     */
    public $implement = [
        \Backend\Behaviors\FormController::class,
        \Backend\Behaviors\ListController::class,
    ];

    public function __construct()
    {
        parent::__construct();

        BackendMenu::setContext('Acorn.Finance', 'finance', 'invoices');
    }
}
