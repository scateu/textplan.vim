What this plugin do?
====================

You are tired of online calendar. Get a plain calendar file with [wcal](https://github.com/leahneukirchen/wcal). Or copy one from [`calendar/`](https://github.com/scateu/textplan.vim/tree/main/calendar)

1. Highlight date lines; Highlight bullet-journal-style symbol lines

2. `>>` `<<` on event lines, shift the bullet left and right accordingly. Out-of-bound bullets will be discarded.

This plugin only takes effect on `*.plan` or `plan` file.

OR add this mode line to any text file:

```
" vim: set ft=textplan:
```

INSTALL
=======
    mkdir -p ~/.vim/pack/plugins/start
    cd ~/.vim/pack/plugins/start
    git clone https://github.com/scateu/textplan.vim

Example
=======

![textplan](https://github.com/user-attachments/assets/1378c087-957f-4bad-855b-951f384e1ac2)

[Youtube](https://youtube.com/shorts/q89Pi-I9gOQ?feature=share)

<img width="416" height="631" alt="Screenshot 2025-08-25 at 10 25 10" src="https://github.com/user-attachments/assets/d4b2b53d-b4ad-4539-862e-4899770b8837" />
<img width="250" height="271" alt="Screenshot 2025-08-25 at 10 25 19" src="https://github.com/user-attachments/assets/13312c96-0794-476e-be5d-f27b816b93a9" />

Design Considerations
=====================

1. No automation. User do all things manually, such as sort, status update, archive, and date change. So there's no need to worry about data flying to location you don't know.
2. Benifit: Users are forced to review all things regularly, because of being involved in all operation.
3. Use Bojo-style keys instead of `- [ ]`, provides more status tracking.

Credit
======

 - https://github.com/leahneukirchen/wcal
 - Alastair Method
 - Gemini 2.5 pro
 - Bullet Journal
 - Org Mode: org-agenda
