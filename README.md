# uLessonScreen

Thought Process Involved in Writing this Project
1. Framework (SwiftUI vs UIKit)
Before starting, I had to choose a framework for development. I eventually chose UIKit for this project because it has backwards compatibility 
with previous iOS versions. Looking at the target market for this project, I found it safe to assume that backwards compatibility would be a high-ranking 
priority for this project.

2. Lint Checks and Structure
I had the codes checked for lints using SwiftLint. 
I used the appropraite camelCases in the project for methods, variables, extensions, fields and classes/structs
Folder names are capitalized
File Names are capitalized
Color Sets in Assets are capitalized
Image names in Assets are capitalized
Consistency was maintained throughout the project

3. Image and JSON Resources
Image resources are added to the assets folder and mock data is added to the Resources folder
the mocked data helped to create the model structs which I decided to use in the project to ensure strong type-checking and to avoid errors in the future
Structs were used to create the models to save memory space
All structs that are used conform to the Codable protocol to make encoding and decoding to json possible

4. Storyboards
One storyboard class is used in the project because of the number of views.
Constraints were used minimally to avoid alignment issues. StackViews were more used to provide a better visual experience on all screen sizes and dimensions. it was tested.
A scrollview is also used in the storyboard to ensure the view is scrollable

5. Views
A collectionView is used in the HomeViewController to display subjects in a scrollable, 2-column format
A tableView is also used in the HomeViewController to display the recently watched section. A nib is used to customise the table view cells. A gestureRecognizer is attached to the cell to perform segue to the video player.
The above are added in the storyboard.
In the SubjectView, A. scrollView and vertical StackView are added from the storyboard.
The repeated views of each chapter and lessons are added from the code behind inside the viewDidLoad method of the view controller
I used the code behind as it was more convenient and suited

6. File structure
I arranged the files in appropriate folders for models, view controllers, for storyboards, for resource for utilities which contains the network caller as well as extensions.The files and folders are  all done logically

7. CocoaPods
I used minimum cocoa pods in the project to save space the only pod used is the SwiftLint for checking the lints in the code. This is to keep app size to a minimum.
The rest of the functionalities are provided by Apple

8. Video Player
I used up Apple's AV video player as the URL video player. it is the native version for Apple's iOS and it works very well. it is displayed in a modal and features the standard video controls.

9. URL images
I extended the UI image view provided by Apple to be able to display images from the URL given in the data

10. Navigation
I used the embedded Navigation link to provide the required navigation service for the project.

11. Customization
I used images and colors to customise the views after initial creation and functionalities were added. The images used for icons are all in the pdf format to save space, the thumbnails in the assets folder are png files and they are provided in the various required size. This was done to ensure sharpness of the images and to save space used by the app.

12. App Versioning
I used git to provide app versioning capabilities on the project. I used a develop branch for changes and I merged app changes to the main branch using the pul request feature. This is done as a standard to prevent directly overwriting the main from a local repo.

Development of this project was centered around fulfilling the designers designs, as well as keeping the app size to a minimum while ensuring minimum footprint on the device battery and storage space
