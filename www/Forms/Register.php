<?php
namespace App\Forms;

use App\core\Validator;

class Register extends Validator {

    public $config = [];

    public $method = "POST";

    public function __construct()
    {
        $this->config = [
            "config"=>[
                "method"=>$this->method,
                "action"=>"",
                "class"=>"form",
                "id"=>"form-register",
                "submit"=>"S'inscrire",
                "cancel"=>"Annuler"
            ],
            "inputs"=>[
                "firstname"=>[
                    "type"=>"text",
                    "placeholder"=>"Votre prénom",
                    "required"=>true,
                    "id"=>"input-firstname",
                    "class"=>"input-text",
                    "min"=>2,
                    "max"=>60,
                    "error"=>"Votre prénom doit faire entre 2 et 60 caractères"
                ],
                "lastname"=>[
                    "type"=>"text",
                    "placeholder"=>"Votre nom",
                    "required"=>true,
                    "id"=>"input-lastname",
                    "class"=>"input-text",
                    "min"=>2,
                    "max"=>120,
                    "error"=>"Votre nom doit faire entre 2 et 120 caractères"
                ],
                "email"=>[
                    "type"=>"email",
                    "placeholder"=>"Votre email",
                    "required"=>true,
                    "id"=>"input-email",
                    "class"=>"input-text",
                    "error"=>"Votre email est incorrect"
                ],
                "password"=>[
                    "type"=>"password",
                    "placeholder"=>"Votre mot de passe",
                    "required"=>true,
                    "id"=>"input-password",
                    "class"=>"input-text"
                ],
                "password-confirm"=>[
                    "type"=>"password",
                    "placeholder"=>"Confirmation",
                    "required"=>true,
                    "id"=>"input-password-confirm",
                    "class"=>"input-text",
                    "confirm"=>"password"
                ]
            ]
        ];

        parent::__construct();
    }

    public function getConfig(): array
    {
        return $this->config;
    }

}