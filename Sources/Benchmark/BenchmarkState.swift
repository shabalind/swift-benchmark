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

public struct BenchmarkState {
    public let settings: BenchmarkSettings
    let iterations: Int
    var startTime: UInt64 
    var endTime: UInt64 
    var measurements: [Double] 

    @inline(__always)
    init(iterations: Int, settings: BenchmarkSettings) {
        self.iterations = iterations
        self.settings = settings
        self.startTime = 0
        self.endTime = 0
        self.measurements = []
        self.measurements.reserveCapacity(iterations)
    }

    @inline(__always)
    public mutating func measure(f: () -> Void) {
        start()
        f()
        end()
    }

    @inline(__always) 
    mutating func reset() {
        self.startTime = 0
        self.endTime = 0
    }

    @inline(__always)
    mutating func start() {
        self.reset()
        self.startTime = now()
    }

    @inline(__always)
    mutating func end() {
        let value = now()
        if self.endTime == 0 {
            self.endTime = value
            record()
        }
    }

    @inline(__always)
    mutating func record() {
        measurements.append(self.duration)
    } 

    @inline(__always)
    var duration: Double {
        return Double(self.endTime - self.startTime)
    }

    @inline(__always)
    mutating func loop(_ benchmark: AnyBenchmark) {
        for _ in 1...self.iterations {
            reset()
            benchmark.setUp()
            start()
            benchmark.run(&self)
            end()
            benchmark.tearDown()
        }
    }
}
