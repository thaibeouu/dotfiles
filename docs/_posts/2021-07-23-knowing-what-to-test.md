---
layout: post
title:  "Knowing what to test"
date:   2021-07-23 08:00:00 -0000
author: Thai Vu
---

A simple and opinionated guide.

### What the tests are for
We write tests to make sure our application/modules work as intended for the users.
To achieve that, we should be able to cover most real-life use cases from our users' perspectives.
Identifying those use cases is a crucial step for realising them into our tests later.

We write both unit and integration tests, but we should put much more emphasis on the latter.
Write unit tests for utility functions, and integration tests for parent components at page- or module-level. 
Unit tests are always nice to have but as the size and complexity of the project grow larger, 
they can and will become a nuisance to write and maintain, not to mention the blazing CI running costs.

### What to include in the tests
We should strive to be as user-centric as we possibly can.

- _User’s visibility_: is the user able to see what we intended to (not) show them on their screen? We won’t have to check visibility for every single line of text out there, just selective ones for each section.

- _User’s interactions_: is the user able to interact with our rendered component in an expected manner? We can use the testing library to mimic user’s interactions, ranging from filling an input, clicking a button or dragging the form, depending on the defined use cases. 

- _Subscription changes_: what happens when there are changes to the redux store object or the media query that the component’s subscribed to? This should normally be covered in the user’s interactions part but there might be cases where we need to pay more attention to, especially when the component receive different props and needs to be re-rendered.

![image-title-here](/assets/images/ie.png){:class="img-post"}

Let’s say we implement a simple popup modal for confirmation on deleting an item, we should aim to test what happens when:

1. the user clicks the button that trigger the modal’s opening
1. check if the texts and the buttons are visible on the modal
1. what should happen when the user clicks either buttons:
  - user clicks OK → the (mocked or not) DELETE API endpoint is called once or the delete action gets dispatched to the store → the modal is closed.
  - user clicks Cancel → the modal is closed.

Hope this helped, and have fun writing tests!
