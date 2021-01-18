#
#  Be sure to run `pod spec lint Argon2Swift.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name             = "Argon2Swift"
  spec.version          = "1.0.0"
  spec.summary          = "A Swift wrapper around the Argon2 reference implementation."
  spec.swift_version = "5.0"

  spec.description      = <<-DESC
    A Swift wrapper around the Argon2 Reference implementation, built for simplicity and ease
  DESC

  spec.homepage         = "https://github.com/tmthecoder/Argon2Swift.git"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #


  spec.license          = { :type => "MIT", :file => "LICENSE" }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "Tejas Mehta" => "tmthecoder@gmail.com" }

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source           = { git: "https://github.com/signalapp/Argon2.git", :tag => spec.version, submodules: true }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  spec.ios.deployment_target = "9.0"
  spec.osx.deployment_target = "10.11"
  spec.watchos.deployment_target = "5.0"
  spec.tvos.deployment_target = "12.0"

  spec.preserve_paths = 'Sources/Argon2', 'Sources/Argon2/include/**/*.h'

  spec.requires_arc = true

  spec.source_files =
    'Sources/**/*.swift',
    'Sources/Argon2/src/argon2.c',
    'Sources/Argon2/src/core.{c,h}',
    'Sources/Argon2/src/thread.{c,h}',
    'Sources/Argon2/src/encoding.{c,h}',
    'Sources/Argon2/src/blake2/blake2.h',
    'Sources/Argon2/src/blake2/blake2b.c',
    'Sources/Argon2/src/blake2/blake2-impl.h',
    'Sources/Argon2/include/**/*.h'
  spec.osx.source_files =
    'Sources/Argon2/src/ref.c',
    'Sources/Argon2/src/blake2/blamka-round-ref.h'
  spec.ios.source_files =
    'Sources/Argon2/src/ref.c',
    'Sources/Argon2/src/blake2/blamka-round-ref.h'
  spec.tvos.source_files =
    'Sources/Argon2/src/ref.c',
    'Sources/Argon2/src/blake2/blamka-round-ref.h'
  spec.watchos.source_files =
    'Sources/Argon2/src/ref.c',
    'Sources/Argon2/src/blake2/blamka-round-ref.h'

  spec.public_header_files = 'Sources/Argon2/include/**/*.h'

end
