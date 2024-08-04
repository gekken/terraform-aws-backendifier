# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
none
##[v1.2.0]
### Added
* Ability to use custom names
* AWS profile as a variable
* Data caller ID
* KMS Key policy to shut Checkov up
* optional tagging to all taggable resources

## Changed
* Updated all dependencies


##[v1.1.0]

### Added
* Changed version to reflect publishing in Terraform Registry
* Updated in examples

##[v1.0.0] - 10 May 2023
* Initial Release

### Added
* All base functionality for backend:

    * S3 Bucket with encryption and logging
    * DynamoDB table for logging
