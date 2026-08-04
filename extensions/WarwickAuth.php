<?php

namespace WSOAuth\AuthenticationProvider;

class WarwickAuth extends AuthProvider {

    /**
	 * @inheritDoc
	 */
	public function __construct(
		string $clientId,
		string $clientSecret,
		?string $authUri,
		?string $redirectUri,
		array $extensionData = []
	) {
		// idk - basic constructor, but don't know if authUri and/or redirectUri are necessary
	}

    /**
	 * @inheritDoc
	 */
	public function login( ?string &$key, ?string &$secret, ?string &$authUrl ): bool {
		// idk
	}

	/**
	 * @inheritDoc
	 */
	public function logout( UserIdentity &$user ): void {
        // idk - maybe not necessary?
	}

	/**
	 * @inheritDoc
	 */
	public function getUser( string $key, string $secret, &$errorMessage ) {
		// idk - make a request to https://websignon.warwick.ac.uk/oauth/authenticate/attributes?
	}

    /**
	 * @inheritDoc
	 */
	public function saveExtraAttributes( int $id ): void {
	}
}