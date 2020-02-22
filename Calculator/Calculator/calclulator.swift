import Foundation

let time = UInt32(NSDate().timeIntervalSinceReferenceDate)

func Rand() -> Double {
       srand48(Int(time))
       let ran: Double = drand48()
       return ran

   }

func factorial(a: Double) -> Double {
    let n = a
    if(n == 1){
      return 1
    }else{
        return n*factorial(a:n-1)
    }
}
   
class Calculator {
    // MARK: - Constants
    enum Operation {
        case equals
        case constant(value: Double)
        case unary(function: (Double) -> Double)
        case binary(function: (Double, Double) -> Double)
        
    }
    
   
    var map: [String : Operation] = [
        "+" : .binary { $0 + $1 },
        "x" : .binary { $0 * $1 },
        "/" : .binary { $0 / $1 },
        "-" : .binary { $0 - $1 },
        "pi": .constant(value: Double.pi),
        "sqrt": .unary{ value in return sqrt(value)},
        "ran": .constant(value: Rand()),
        "x!": .unary{ x in return factorial(a: x)},
        "x^y": .binary {pow($0, $1)},
        "1/x": .unary{1/$0},
        "%": .unary{$0*0.1},
        "=" : .equals
    ]
        
    // MARK: - Variables
    var result: Double = 0
    var lastBinaryOperation: ((Double, Double) -> Double)?
    var reminder: Double = 0
    
    // MARK: - Methods
    func setOperand(number: Double) {
        result = number
    }
    
    func executeOperation(symbol: String) {
        guard let operation = map[symbol] else {
            print("ERROR: no such symbol in map")
            return
        }

        
        switch operation {
        case .constant(let value):
            result = value
        case .unary(let function):
            result = function(result)
        case .binary(let function):
            if lastBinaryOperation != nil {
                executeOperation(symbol: "=")
            }
            
            lastBinaryOperation = function
            reminder = result
            
        case .equals:
            if let lastOperation = lastBinaryOperation {
                result = lastOperation(reminder, result)
                lastBinaryOperation = nil
                reminder = 0
            }
        }
    }
}
