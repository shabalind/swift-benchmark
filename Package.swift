// swift-tools-version:5.1

// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import PackageDescription

let optimize = [SwiftSetting.unsafeFlags(["-cross-module-optimization", "-O"])]

let package = Package(
    name: "Benchmark",
    products: [
        .library(
            name: "Benchmark",
            targets: ["Benchmark"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "Benchmark",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")],
            swiftSettings: optimize),
        .target(
            name: "BenchmarkMinimalExample",
            dependencies: ["Benchmark"],
            swiftSettings: optimize),
        .target(
            name: "BenchmarkSuiteExample",
            dependencies: ["Benchmark"],
            swiftSettings: optimize),
        .testTarget(
            name: "BenchmarkTests",
            dependencies: ["Benchmark", "BenchmarkSuiteExample"],
            swiftSettings: optimize),
    ]
)
