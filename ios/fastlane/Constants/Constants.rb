# frozen_string_literal: true

class Constants
  #################
  #### PROJECT ####
  #################

  # Workspace path
  def self.WORKSPACE_PATH
    './Runner.xcworkspace'
  end

  # Project path
  def self.PROJECT_PATH
    './Runner.xcodeproj'
  end

  # bundle ID for Staging app
  def self.BUNDLE_ID_STAGING
    'com.flutteric.kayla.staging'
  end

  # bundle ID for Production app
  def self.BUNDLE_ID_PRODUCTION
    'com.flutteric.kayla'
  end

  #################
  #### BUILDING ###
  #################

  # a derived data path
  def self.DERIVED_DATA_PATH
    './DerivedData'
  end

  # a build path
  def self.BUILD_PATH
    './Build'
  end
  
  #################
  #### KEYCHAIN ####
  #################

  # Keychain name
  def self.KEYCHAIN_NAME
    'github_action_keychain'
  end

  def self.KEYCHAIN_PASSWORD
    'password'
  end

  #################
  ### ARCHIVING ###
  #################
  # an staging environment scheme name
  def self.SCHEME_NAME_STAGING
    'staging'
  end

  # a Production environment scheme name
  def self.SCHEME_NAME_PRODUCTION
    'production'
  end

  # an staging product name
  def self.PRODUCT_NAME_STAGING
    'Flutter Survey Staging'
  end

  # a staging TestFlight product name
  def self.PRODUCT_NAME_STAGING_TEST_FLIGHT
    'Flutter Survey Staging'
  end

  # a Production product name
  def self.PRODUCT_NAME_PRODUCTION
    'Flutter Survey'
  end

  # a main target name
  def self.MAIN_TARGET_NAME
    'Runner'
  end

  # App Store Connect API Key ID
  def self.APP_STORE_KEY_ID
    'TKJCMGPSYH'
  end

  # App Store Connect API Issuer ID
  def self.APP_STORE_ISSUER_ID
    '69a6de82-b7cb-47e3-e053-5b8c7c11a4d1'
  end

  def self.DEV_PORTAL_TEAM_ID
    '4TWS7E2EPE'
  end
end
