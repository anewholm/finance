<?php

return [
    'plugin' => [
        'name' => 'Finance',
        'description' => 'No description provided yet...',
    ],
    'permissions' => [
        'some_permission' => 'Some permission',
    ],
    'models' => [
        'currency' => [
            'symbol' => 'Symbol',
            'shortname' => 'Shortname',
            'label' => 'Currency',
            'label_plural' => 'Currencies',
        ],
        'general' => [
            'add' => 'Add',
            'name' => 'Name',
            'id' => 'ID',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
        ],
        'invoice' => [
            'backend_user_group' => ' Client Organisation',
            'backend_user' => ' Client',
            'amount' => 'Amount',
            'mark_paid' => 'Mark Paid',
            'currency' => 'Currency',
            'number' => 'Number',
            'label' => 'Invoice',
            'label_plural' => 'Invoices',
        ],
        'payment' => [
            'backend_user_group' => ' Client Organisation',
            'backend_user' => ' Client',
            'number' => 'Number',
            'amount' => 'Amount',
            'currency' => 'Currency',
            'invoice' => 'Invoice',
            'label' => 'Payment',
            'label_plural' => 'Payments',
        ],
        'purchase' => [
            'backend_user_group' => ' Client Organisation',
            'backend_user' => ' Client',
            'amount' => 'Amount',
            'currency' => 'Currency',
            'mark_paid' => 'Mark Paid',
            'number' => 'Number',
            'label' => 'Purchase',
            'label_plural' => 'Purchases',
        ],
        'receipt' => [
            'backend_user_group' => ' Client Organisation',
            'backend_user' => ' Client',
            'amount' => 'Amount',
            'currency' => 'Currency',
            'number' => 'Number',
            'purchase' => 'Purchase',
            'label' => 'Receipt',
            'label_plural' => 'Receipts',
        ],
    ],
];


// general.name
// general.add
// currency.shortname
// currency.symbol
// invoice.number
// invoice.currency
// invoice.mark_paid
// invoice.amount
// invoice.backend_user
// invoice.backend_user_group
// payment.invoice
// payment.currency
// payment.amount
// payment.number
// payment.backend_user
// payment.backend_user_group
// purchase.number
// purchase.mark_paid
// purchase.currency
// purchase.amount
// purchase.backend_user
// purchase.backend_user_group

// receipt.purchase
// receipt.number
// receipt.currency
// receipt.amount
// receipt.backend_user
// receipt.backend_user_group
