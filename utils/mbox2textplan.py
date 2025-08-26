# Convert .mbox file to .plan format
# gemini-2.5-pro>
# Hi, I'd like to convert mbox file, which contains a lots of emails, to a plain text file. The plain text file has the following format
# . SUBJECT
#   [Email Contents if there's any. Drop the email signature part starts with ---]
# . SUBJECT
# . SUBJECT
# each line of cleaned_body need three space

import mailbox
import os
import argparse
import textwrap
from email.header import decode_header, make_header

def get_decoded_header(header_value):
    """Decodes an email header into a clean string."""
    if header_value is None:
        return ""
    # The make_header function handles decoding and joining multiple encoded parts.
    decoded = make_header(decode_header(header_value))
    return str(decoded).replace('\n', ' ').replace('\r', '')

def get_text_body(message):
    """
    Extracts the plain text body from an email message.
    It walks through multipart messages and finds the 'text/plain' part.
    """
    body = ""
    # If the message is multipart, walk through its parts to find the text part.
    if message.is_multipart():
        for part in message.walk():
            content_type = part.get_content_type()
            content_disposition = str(part.get('Content-Disposition'))

            # We want the plain text part that is not an attachment.
            if content_type == 'text/plain' and 'attachment' not in content_disposition:
                payload = part.get_payload(decode=True)
                charset = part.get_content_charset() or 'utf-8'
                try:
                    body = payload.decode(charset, errors='replace')
                except (UnicodeDecodeError, LookupError):
                    # Fallback if the specified charset is wrong or unsupported
                    body = payload.decode('latin-1', errors='replace')
                break # Found the plain text body, no need to look further
    else:
        # If it's not multipart, it should be the payload itself.
        if message.get_content_type() == 'text/plain':
            payload = message.get_payload(decode=True)
            charset = message.get_content_charset() or 'utf-8'
            try:
                body = payload.decode(charset, errors='replace')
            except (UnicodeDecodeError, LookupError):
                body = payload.decode('latin-1', errors='replace')

    return body

def strip_signature(text):
    """
    Strips the signature from an email body.
    Common signatures start with a line containing only '-- ' or '---'.
    """
    lines = text.splitlines()
    for i, line in enumerate(lines):
        # A common signature delimiter is '-- ' (dash, dash, space)
        # We also check for '---' as a fallback.
        if line.strip() == '--' or line.strip() == '---' or line.strip() == '-- ':
            return '\n'.join(lines[:i]).strip()
    return text.strip()

def convert_mbox_to_text(mbox_path, output_path):
    """
    Converts an mbox file to a formatted plain text file.

    Format:
     . [SUBJECT]
       [Email Contents without signature]
    """
    if not os.path.exists(mbox_path):
        print(f"Error: Mbox file not found at '{mbox_path}'")
        return

    # The 'mailbox.mbox' class is perfect for reading mbox files
    mbox = mailbox.mbox(mbox_path)
    count = 0

    print(f"Opening mbox file: {mbox_path}")
    print(f"Starting conversion... will write to: {output_path}")

    with open(output_path, 'w', encoding='utf-8') as outfile:
        for message in mbox:
            count += 1
            # Get and clean the subject
            subject = get_decoded_header(message['Subject']) or "(No Subject)"
            
            # Write the subject line in the specified format
            outfile.write(f" . {subject}\n")

            # Get the plain text body
            body = get_text_body(message)

            if body:
                # Strip the signature and any leading/trailing whitespace
                cleaned_body = strip_signature(body)
                if cleaned_body:
                    # Write the content only if it's not empty after cleaning
                    indented_body = textwrap.indent(cleaned_body, '   ')
                    outfile.write(indented_body + "\n")
            
            # Add a visual separator for clarity in the output file, consistent with the format
            # This ensures even emails with no body content are distinctly separated.
            # Based on the user's example, it seems the next ". [SUBJECT]" is the separator.
            # So, we don't need to add an extra one.

    print(f"\nConversion complete. Processed {count} emails.")
    print(f"Plain text file saved to: {output_path}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Convert an mbox file to textplan .plan file.",
        formatter_class=argparse.RawTextHelpFormatter
    )
    parser.add_argument("mbox_file", help="The path to your input .mbox file.")
    parser.add_argument("output_file", help="The path for the output .plan text file.")
    
    args = parser.parse_args()
    
    convert_mbox_to_text(args.mbox_file, args.output_file)

