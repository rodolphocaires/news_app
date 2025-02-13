# News App

App to show news based on newsapi org

<img width="160" alt="image" src="https://github.com/user-attachments/assets/89d3d9af-32d4-4503-b13b-485fcc62effa">
<img width="160" alt="image" src="https://github.com/user-attachments/assets/c220c4ea-b804-48cc-80a2-b3f1946438c2">
<img width="160" alt="image" src="https://github.com/user-attachments/assets/b35d888c-ca86-46fa-bf16-5e6941599f2f">
<img width="160" alt="image" src="https://github.com/user-attachments/assets/244d8424-5e19-4a1f-998f-69d343901932">

***

And let's understand how this project was implemented below.

## Dependency Injection and Router

The first item valid to be mentioned for the project involves the whole structure which it is based. We are basically working with two different structures:

 1. **Dependency Injection**: We use Get It as a Service Locator as our dependency injection (DI) system that helps managing dependencies in a clean and maintainable way. Dependency injection in Flutter applications helps decouple object creation from the business logic, promoting better testability and reusability.

 2. **Route Management**: Our structure allows each feature to manage its own routes. This keeps route definitions clean and concise, making the app's navigation structure more intuitive and easier to manage.

The application starts in `lib/base` folder, where we can find the `main.dart`, `bootstrap.dart` to load injections and environment configs, and injection and router structures. 

Then, we move to `lib/features`, finding the features implemented as modules, and also using `Clean Architecture` to separate the different layers and responsibilities. 

## Clean Architecture

To enhance the maintainability and scalability of the application, I adopted the `Clean Architecture` pattern for the features. This architectural approach ensures a clear separation of concerns and adheres to SOLID principles, which are crucial for building robust and testable software.

~~~
feature/
├── presentation/
├── domain/
└── data/
~~~

The project is divided into several layers, each with a specific role:

* **Presentation Layer**: Contains the UI components and handles user interactions.
* **Domain Layer**: Encapsulates the business logic and use cases.
* **Data Layer**: Manages data sources, repositories, and data models.

In our features, we can see additional layers, such as `di (dependency injection)`, which creates creates all the connectios between the interfaces and implementations; and `routes`, to organize better the definition for each route within the feature.

As we are doing the best usage of `SOLID` principles, we have one which is a special case: `Dependency Inversion`. This principle helps us to avoid classes depending directly from the implementation, but depending from contracts (interfaces or abstract classes). It allows us to receive dependencies in our classes' constructor, and mock their behavior to write **tests**.

## Before running the app

To run the app properly, you have to create a file called `.env`, in the root path of the application.

~~~
news_app/
├── lib/
├── .env-example
└── .env
~~~

To prevent sharing sensitive data, we can configure locally some of the keys and configuration for our app. As specified within the file `.env-example`, for the config `NEWS_API_KEY` we define the key to access the API, which can be [found here](https://newsapi.org/); and for the config `BACKGROUND_FETCH_INTERVAL_SECONDS`, we can define the interval (in seconds) for the application to fetch live news from the NewsAPI ORG. 

![image](https://github.com/user-attachments/assets/a3e180c9-a6af-4bf2-a3bf-54b2dbfc490e)

Below we can see the Flutter and Dart version when the app was implemented. 

![image](https://github.com/user-attachments/assets/32fd46c0-020a-4fd3-8c6f-21ac125c32b3)
