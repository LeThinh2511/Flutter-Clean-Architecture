# TDD Clean Architecture for Flutter

## How to run project
- Run `flutter pub get` to fetch all the dependencies

## Tips
1. if `builder_runner` is looking for `pubspec.yaml` in the wrong place. Using `flutter packages pub run build_runner build` instead of `dart run build_runner build`

Guideline for clean architecture in flutter

## Getting Started
Ref: https://resocoder.com

<br />

<h3 align="center">Architecture Proposal</h3>

<br />

<img src="./architecture-proposal.png" style="display: block; margin-left: auto; margin-right: auto; width: 75%;"/>

<br />

# Presentation
- This is the stuff you're used to from "unclean" Flutter architecture. You obviously need widgets to display something on the screen. These widgets then dispatch events to the Bloc and listen for states (or an equivalent if you don't use Bloc for state management).
```
Note that the "Presentation Logic Holder" (e.g. Bloc) doesn't do much by itself. It delegates all its work to use cases. At most, the presentation layer handles basic input conversion and validation.
```

# Domain
- Domain is the inner layer which shouldn't be susceptible to the whims of changing data sources or porting our app to Angular Dart. It will contain only the core business logic (use cases) and business objects (entities). It should be totally independent of every other layer.
```
Use Cases are classes which encapsulate all the business logic of a particular use case of the app (e.g. GetConcreteNumberTrivia or GetRandomNumberTrivia).
```

# Data
- The data layer consists of a Repository implementation (the contract comes from the domain layer) and data sources - one is usually for getting remote (API) data and the other for caching that data. Repository is where you decide if you return fresh or cached data, when to cache it and so on.
