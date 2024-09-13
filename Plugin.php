<?php

namespace Acorn\Finance;

use Backend;
use Backend\Models\UserRole;
use System\Classes\PluginBase;

/**
 * Finance Plugin Information File
 */
class Plugin extends PluginBase
{
    public $require = ['Acorn.Calendar', 'Acorn.Location', 'Acorn.Messaging'];
    /**
     * Returns information about this plugin.
     */
    public function pluginDetails(): array
    {
        return [
            'name'        => 'acorn.finance::lang.plugin.name',
            'description' => 'acorn.finance::lang.plugin.description',
            'author'      => 'Acorn',
            'icon'        => 'icon-leaf'
        ];
    }

    /**
     * Register method, called when the plugin is first registered.
     */
    public function register(): void
    {

    }

    /**
     * Boot method, called right before the request route.
     */
    public function boot(): void
    {

    }

    /**
     * Registers any frontend components implemented in this plugin.
     */
    public function registerComponents(): array
    {
        return []; // Remove this line to activate

        return [
            'Acorn\Finance\Components\MyComponent' => 'myComponent',
        ];
    }

    /**
     * Registers any backend permissions used by this plugin.
     */
    public function registerPermissions(): array
    {
        return []; // Remove this line to activate

        return [
            'acorn.finance.some_permission' => [
                'tab' => 'acorn.finance::lang.plugin.name',
                'label' => 'acorn.finance::lang.permissions.some_permission',
                'roles' => [UserRole::CODE_DEVELOPER, UserRole::CODE_PUBLISHER],
            ],
        ];
    }

    /**
     * Navigation in plugin.yaml.
     */
}

// Created By acorn-create-system v1.0
