What this plugin do?
====================

Your todo list bankrupts every 3 months. You are tired of online calendar. Get a plain calendar file with [wcal](https://github.com/leahneukirchen/wcal). Or copy one from [`calendar/`](https://github.com/scateu/textplan.vim/tree/main/calendar)

1. Highlight date lines; Highlight bullet-journal-style symbol lines

2. `>>` `<<` on event lines, shift the bullet left and right accordingly. Out-of-bound bullets will be discarded.

This plugin only takes effect on `*.plan` or `plan` file.

**OR** add this mode line to any text file:

```
" vim: set ft=textplan:
```

Design Considerations
=====================

1. **No automation.** User has to do all things manually, such as sort, status update, archive, and date change. 
  - Benifit 1: So there's no need to worry about data flying to location you don't know.
  - Benifit 2: Users are forced to review all things regularly, because of being involved in each operation.
2. **Bujo-style keys** instead of `- [X]`, provides more status tracking.
3. **Preserve breadcrumb**: Items marked as DONE will encourge people. Let user move DONE items later.


INSTALL
=======
    mkdir -p ~/.vim/pack/plugins/start
    cd ~/.vim/pack/plugins/start
    git clone https://github.com/scateu/textplan.vim

Example
=======

![ezgif-2454189dc7d8ac](https://github.com/user-attachments/assets/582d0fe5-e26b-4edc-98fa-08457adb2b37)

[Youtube1](https://youtube.com/shorts/q89Pi-I9gOQ?feature=share) [Youtube2](https://youtube.com/shorts/iFs2oQF_3LY)

<img width="416" height="631" alt="Screenshot 2025-08-25 at 10 25 10" src="https://github.com/user-attachments/assets/d4b2b53d-b4ad-4539-862e-4899770b8837" />
<img width="250" height="271" alt="Screenshot 2025-08-25 at 10 25 19" src="https://github.com/user-attachments/assets/13312c96-0794-476e-be5d-f27b816b93a9" />
![textplan](https://github.com/user-attachments/assets/1378c087-957f-4bad-855b-951f384e1ac2)



SYNTAX
======

```
Calendar Line: 

34 Aug  18 19 20 21 22 23 24
OR
34      18 19 20 21 22 23 24

Item Line:
                  o           Description. Press << or >> will shift date left/right
                        =     Waiting for someone
            .                 Can be any other symbol you like

 ! As long as leading spaces >= 1


* Chapter 1: Press Tab Here: Foldable
37       8  9 10 11 12 13 14
38      15 16 17 18 19 20 21
39      22 23 24 25 26 27 28

# Chapter 2: * # treated equally


# Projects
Project 1:
 x Done something
 . Do something
Project 2:
 = Waiting for someone
 x Done something
```

Credit
======

 - https://github.com/leahneukirchen/wcal
 - Alastair Method
 - Gemini 2.5 pro
 - Bullet Journal
 - Org Mode: org-agenda
 - Marc Andreessen's Method: {Todo, Watch, Later} List
