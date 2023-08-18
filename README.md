# SwiftRuler

The module to reduce complexity of iterative programing. By using rule base to verify candidate. 

## Concept

**SwiftRuler** will change from this.

```swift
if firstNameTextField.text?.isEmpty ||
   lastNameTextField.text?.isEmpty ||
   passwordTextField.text?.isEmpty {
    print("Field Missing")
} else if let password = passwordTextField.text {
    if password.count > 8 {
      print("Password is Too Short")
    } else if password.contain(" ") {
      print("Password Contains Space")
    }
} else {
    print ("User Created")
}
```

To this.

```swift
  var ruler = Ruler()
  ruler.add(firstNameTextField, rule: EmptyStringRule(), userInfo: "Field Missing")
  ruler.add(lastNameTextField, rule: EmptyStringRule(), userInfo: "Field Missing")
  ruler.add(passwordTextField, rule: EmptyStringRule(), userInfo: "Field Missing")
  ruler.add(passwordTextField, rule: StringRangeRule(min: 8), userInfo: "Password is Too Short")
  ruler.add(passwordTextField, rule: RegexRule("\\s"), userInfo: "Password Contains Space")
  
  guard let result = ruler.validate() {
    print(result.userInfo)
    return
  } 
  
  print("User Created")
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

**SwiftRuler** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftRuler"
```

## Usage

**SwiftRuler** is rules base element validation. The concept is pre-setup rule on initial stage and validate later. To avoid many iterative coding. and keep readability. Here is the example of use:

```swift
class ViewController: UIViewController {

  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  let ruler = Ruler()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Add rule
    ruler.add(usernameTextField, rule: EmptyStringRule(), userInfo: "Username must not empty.")
    ruler.add(passwordTextField, rule: EmptyStringRule(), userInfo: "Password must not empty.")
    ruler.add(passwordTextField, rule: StringRangeRule(min: 6), userInfo: "Password must contain 6 or more characters.")
  }

  @IBAction func validate() {
    /// Validate rule
    if let error = ruler.validate() {
      // Fail
      showAlert(error.userInfo)
      return
    }

    // Success
    submit()
  }

}

```

### Add rules

Add single rule to one element

```swift
ruler.add(textField, rule: EmptyStringRule(), userInfo: "Text must not empty.")
```

Add multiple rules to one element

```swift
ruler.add(textField, rules: [EmptyStringRule(), EmailRule()], userInfo: "Text isn't email.")
```

Add multiple rules with difference userInfo to one element

```swift
ruler.add(textField, 
          rules: [(EmptyStringRule(), userInfo: "Text must not empty."),
                  (EmailRule(), userInfo: "Text isn't email.")])
```

UserInfo can also send other type of object e.g. Dictionary, Array, String.

### Validation

Validate for first error, if there are some error. This method will return first error.

```swift
let error = ruler.validate()
guard error == nil else {
  // Fail
}
// Pass
```

Validate for all errors, if there are some error. This method will return all error as array.

```swift
let errors = ruler.validateAll()
guard errors.isEmpty else {
  // Fail
  return
}

// Pass
```

If you want to validate the candidate that to pre-add in the list. You can call and add candidate immediately.

```swift
guard EmailRule().validate(candidate: instanceText) else {
  // Fail
  return
}

// Pass
```

## Rule

**SwiftRuler** contain some rule for you to use. Here is the list of the rule.

### ConnectToInternetRule

Rule for checking is device can connect to internet or not. Not require candidate.

```swift
ConnectToInternetRule()
```

### DateTimeRule:

Rule for checking is candidate in the range of time between specific date time. Required candidate to check. Here the properties of this rule:

* MinimumDateTime: Minimum date time for checking, default is current date time
* MaximumDateTime: Maximum date time for checking, default is current date time plus 100 years.
* DateTimeFormatter: Formatter for convert String candidate to Date object. default is "dd/MM/yy-hh:mm:ss" with current locale.

```swift
 DateTimeRule(min: newDate, max: Date(timeIntervalSinceNow: 604800), formatter: dateFormatter.dateFormat)
```

### EmailRule

Rule for checking candidate is in email format or not. Required candidate to check.

```swift
EmailRule()
```

### EmptyStringRule

Rule for checking candidate is empty or not. Use of mandatory field. Required candidate to check. ignoreCharacterSet is use for character set that want to ignore
for validation.

```swift
EmptyStringRule()
EmptyStringRule(ignoreCharacterSet: .whiteSpace)
```

### RegexRule

Rule for checking candidate is follow regular expression format. Required candidate to check. Here the properties of this rule:

* Expression: The Regular Expression String.

```swift
RegexRule("[a-zA-Z]")
```

### TrueRule

Rule for checking candidate is in *true*. Required candidate to check.

```swift
TrueRule()
```

### FalseRule

Rule for checking candidate is in *false*. Required candidate to check.

```swift
FalseRule()
```

### StringRangeRule

Rule for checking candidate's character is in range or not. Required candidate to check. Here the properties of this rule:

* Range: The range to checking. default is 0 ... Int.max
* Invert: This will invert the rule if set to true. default is false.

```swift
StringRangeRule(3...8, inverted: false)
StringRangeRule(max: 12)
```

### Custom rule

You can create custom rule by conform to *Rule* protocol or inherit *StringRule* to create string-base rule class.

```swift
class IsARule: Rule {
  func validate(candidate: Any?) -> Bool {
    return candidate as? String == "A"
  }
}
```

## Rulable

**SwiftRuler** only can validate elements that conform to *Rulable* protocol. There are some UI Element that already assign as *Rulable*. in list below:

* UITextField: Capture *text* parameter.
* UITextView: Capture *text* parameter.
* UISwitch: Capture *isOn* parameter.
* UIButton: Capture *isSelected* parameter.
* UILabel: Capture *text* parameter.
* Primitive Object: String, Int, Double, Float, Bool. 

**TrimStringRuler** this rulable is support trimming string before proceed validation.

```swift
let ruler = Ruler()
ruler.add(TrimStringRulable(rulable: usernameTextField, trimmingCharacters: .whitespacesAndNewlines), rule: EmptyStringRule())
ruler.add(emailTextField.rulable(byTrimmingStringIn: .whitespacesAndNewlines), rule: EmailRule()) // or using Rulable extension
ruler.validate()
```

### Compare Rulable

A custom rulable for checking 2 candidates value. this will capture value in *Rulable* UI Element and compare. Comparason value should be same type, this  rulable will return Bool value for rule. Example below:

```swift
let rulable = CompareRulable(candidate: passwordTextField,
                             other: confirmPasswordTextField)
ruler(rulable,
      rule: TrueRule(),
      userInfo: "Password is not match, Please try again.")

```

### Rule Block

**SwiftRuler** can use block to validate in case of quick use.

```swift
let ruleBlock = RuleBlock {
  return passwordTextField.text == confirmPasswordTextField.text
}

ruler.add(ruleBlock,
          rule: TrueRule(),
          userInfo: "Password not equal.")
```

### Custom Rulable

You can also conform *Rulable* protocol to your custom view. By define *candidateValue* to let **SwiftRuler** validate the value.

```swift
class CustomView: UIView, Rulable {
  let customTextField = UITextField()

  var candidateValue: Any? {
    return customTextField.text
  }
}
```

## Change log

* Version 1.0.0:
    * Initialize version
* Version 1.1.0:
    * Add standard object (String, Int, Double, Float and Bool) as Rulable object.
* Version 1.1.1:
    * Fix primitive type and not apply in Rulable.
* Version 1.2.0:
    * Add IgnoreCharacterSet in EmptyStringRule.
* Version 1.2.1:
    * Fix Email Rule to validate whole word.
* Version 1.3.0:
    * Add TrimStringRulable to support trimming string before validation.
* Version 1.3.1:
    * Fix compile error on StringRule.
* Version 2.0.0:
    * Remove support For object C
    * Add generic type on UserInfo
* Version 2.0.1:
    * Remove NSObject from rule
* Version 2.0.2:
    * Remove case insensitive option from Regex rule
    * Upgrade to swift 5
* Version 2.1.0:
    * Fix cannot conform Rulable protocol in UIView
    * Remove 'ConnectToInternetRule' to reduce dependency

## Author

* Siwasit Anmahapong [@bazaku](https://github.com/bazak)
* Rawipon Srivibha [@phoeniex](https://github.com/phoeniex)
