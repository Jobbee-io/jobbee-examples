<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Flash to HTML5: rebuilding a classroom interactive for the iPad

Brightkettle Studio, for the Larchmere Science Center, a regional science museum, February to June 2011. One line in my resume's Earlier section, which is all it deserves there. The file stays because three habits I still use started here: test on the weakest device, keep content out of the code that runs it, and treat accessibility as a requirement that comes from real people.

## The full story

By late 2010 the watershed interactive the studio had built in 2008 was stuck. About 300 classrooms used it, the iPad couldn't run Flash, and districts in the region were piloting iPads. The museum's education director asked for a version that worked on them before the fall 2011 term. We started in February 2011: three developers and one designer, with me as lead developer and the account lead handling the budget and the client.

The first call was to cut. The usage logs showed 8 of the 22 modules under 5% of sessions, and the education director agreed to drop them. Then the designer and I spent about 3 weeks moving the content out of the Flash timelines into JSON by hand. It was the riskiest part of the job, and it wasn't in the estimate.

My first prototype drew everything on canvas and ran at about 9 frames per second on a first-generation iPad. I had tested on a desktop and a laptop. Moving the interface to HTML and CSS, and redrawing only what changed, got it past 25. Meanwhile one developer built the module navigation and the kiosk mode, and the other built the teacher pages.

The classroom pilot found two things. Students rotated the iPads, and the landscape-only layout broke. And a teacher asked whether a blind student in the class could use it. Portrait layout, keyboard controls and a text description of each simulation step went into the last month. They are where the 2 extra weeks went: 17 against a fixed fee that assumed 15, absorbed by the studio.

We shipped in June 2011. Nothing is left open. The museum ran this version until 2019, and the education director wrote to tell me when they retired it.

## What it was

In 2008 Brightkettle built the museum a Flash interactive about watersheds: 22 modules in which students follow rainwater from a hillside down to the Missouri River and change how the land is used to see what happens to the river. By 2010 about 300 classrooms used it each school year, and the museum ran it on kiosks in its main hall. The iPad shipped without Flash in April 2010, several districts in the region had iPad pilots by late 2010, and the museum's education director asked us for a version that worked on iPads before the fall 2011 term.

## My role

Lead developer on a team of three developers and one designer. I made the technical calls, built the river simulation, and extracted the content with the designer. One developer built the module navigation and the kiosk mode; the other built the teacher pages. The account lead handled the budget and the client.

## Decisions

- Cut first. The Flash version logged module usage, and 8 of the 22 modules got under 5% of sessions. With the education director's agreement we rebuilt 14 and dropped 8. That made June possible.
- Content out of code. Text, images and step data lived inside the Flash timelines. The designer and I moved them into JSON files by hand, in about 3 weeks.
- Canvas only for the river simulation. Everything else became plain HTML and CSS transitions, with jQuery.
- Safari on iOS won't play audio without a user gesture, so the narration, which had autoplayed, got a start step that the teacher taps. Teachers liked controlling when the sound started.
- The teacher pages became plain HTML with print styles, because teachers printed the worksheets. They got more use than I expected.

## The numbers

- Modules: 22 to 14.
- Simulation on a first-generation iPad: about 9 frames per second in my first prototype, 25+ at launch.
- Schedule: 17 weeks against a fixed fee that assumed 15. The studio absorbed the 2 extra weeks, which went to the portrait layout and the accessibility work.
- Shipped June 2011. In the 2011–2012 school year, 41% of sessions came from iPads, by the museum's own analytics. The museum ran this version until 2019, and the education director wrote to tell me when they retired it.

## What went wrong

- My first prototype drew everything on canvas at 30 frames per second, menus and labels included, and ran at about 9 on a first-generation iPad. I had tested on my desktop and a laptop. Moving the interface to HTML and CSS, and redrawing only the parts of the canvas that changed, fixed it.
- I built for landscape at 1024×768 only. In the classroom pilot, students rotated the iPads and the layout broke. Portrait took a week of the last month.
- Accessibility wasn't in the plan. In the pilot, a teacher asked whether a blind student in the class could use it, and the Flash version couldn't be used without a mouse. We added keyboard controls and a text description of each simulation step. That was the teacher's idea, not mine, and it was the first accessibility work I ever did.
- The content extraction was most of the risk and none of the original estimate. Today I'd price it as its own line item.
