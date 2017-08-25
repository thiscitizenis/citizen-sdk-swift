## Swift SDK for the Citizen secure login and data exchange service

More about the Citizen Service can be found here:

  https://www.citizen.is/

and here:

  https://developers.citizen.is/

A skeleton app using this SDK can be found here: 

  https://github.com/thiscitizenis/citizen-example-app-swift

It has examples of the following tasks:

  - Create a new user (CreateNewUserExample.swift).
  - Log in with a username and password (PasswordLoginExample.swift).
  - Create a key pair for fingerprint login and signing (CreateFingerprintKeyExample.swift).
  - Log in using a fingerprint signature (FingerprintLoginExample.swift).
  - Set the user's name (SetNameExample.swift).
  - Set the user's phone details (SetPhoneExample.swift).
  - Confirm the user's phone with a code sent by SMS (ConfirmPhoneExample.swift).
  - Set the user's date of birth, nationality and place of birth (SetOriginExample.swift).
  - Set the user's address (SetAddressExample.swift).
  - Get the user's details eg name, phone, DOB etc (GetPersonExample.swift).
  - Issue tokens (IssueTokenExample.swift).
  - Get token requests (GetRequestedTokensExample.swift).
  - Grant a token (GrantTokenExample.swift).
  - Decline a token (DeclineTokenExample.swift).
  - Verify a token (VerifySignedTokenExample.swift).
  - Log in in via a web browser by approving a token (GrantWebLoginTokenExample.swift).

The SDK can be added to an XCode project by building the framework and adding 'CitizenSDK.framework' to the 'embeded binaries' section in the project's 'General' tab.

Support for installing by Cocoa Pods will be added shortly.
