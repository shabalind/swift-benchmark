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

/// Functions for pretty column output formatting.
public enum BenchmarkFormatter {
    public typealias Formatter = (Double, BenchmarkSettings) -> String

    /// Just show a number, stripping ".0" if it's integer.
    public static let number: Formatter = { (value, settings) in
        let string = String(value)
        if string.hasSuffix(".0") {
            return String(string.dropLast(2))
        } else {
            return string
        }
    }

    /// Show number with the corresponding time unit.
    public static let time: Formatter = { (value, settings) in
        switch settings.timeUnit {
        case .ns: return "\(value) ns"
        case .us: return "\(value/1000.0) us"
        case .ms: return "\(value/1000_000.0) ms"
        case .s: return "\(value/1000_000_000.0) s"
        }
    }

    /// Show number with the corresponding inverse time unit.
    public static let inverseTime: Formatter = { (value, settings) in
        switch settings.inverseTimeUnit {
        case .ns: return "\(value) /ns"
        case .us: return "\(value*1000.0) /us"
        case .ms: return "\(value*1000_000.0) /ms"
        case .s: return "\(value*1000_000_000.0) /s"
        }
    }

    /// Show value as percentage.
    public static let percentage: Formatter = { (value, settings) in
        return String(format: "%6.2f %%", value)
    }

    /// Show value as plus or minus standard deviation.
    public static let std: Formatter = { (value, settings) in
        return "± " + String(value)
    }

    /// Show value as plus or minus standard deviation in percentage.
    public static let stdPercentage: Formatter = { (value, settings) in
        return "± " + String(format: "%6.2f %%", value)
    }
}
