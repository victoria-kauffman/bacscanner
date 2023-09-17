## Inspiration

Irresponsible substance use causes fatalities due to accidents and related incidents. Driving under the influence is one of the top 5 leading causes of death in young adults. 37 people die every day from a DUI-related accident--that's one person every 38 minutes. We aspire to build a convenient and accessible app that people can use to accurately determine whether they are in good condition to drive.

## What it does

BACScanner is a computer vision mobile app that compares iris–pupil ratio before and after substance intake for safer usage.

## How we built it

We built the mobile app with SwiftUI and the CV model using Pytorch and OpenCV. Our machine learning model was linked to the frontend by deploying a Flask API.

## Challenges we ran into

We were originally hoping to be able to figure out your sobriety based on one video of your eyes. However, found that it was fundamental to take a sober image as a control image to compare to and we had to amend our app to support taking a "before" image and an "after" image, comparing the two.

## Accomplishments that we're proud of

We implemented eye tracking and the segmentation neural network with 92% accuracy. We also made an elegant UI for the mobile app.

## What we learned

We learned about building full-stack apps that involve ML. Prior to this, we didn't know how to attach an ML model to a frontend app. We thus learned how to deploy our ML model to an API and link it to our front end using Flask.

## What's next for BACScanner

We hope to be able to add better recognition for narcotic usage, as right now our app can only accurately detect BAC.
