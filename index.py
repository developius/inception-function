from http_parser.pyparser import HttpParser
import sys
import inception

def read_body(content_length):
    return sys.stdin.read(content_length)
    
def read_head():
    buf = None
    while(True):
        line = sys.stdin.buffer.readline()
        if buf == None:
            buf = line
        else:
            buf += line

        if line.decode("utf-8") == "\r\n":
            break
        elif line.decode("utf-8") == "" or line == None:
            break

    return buf

def main():

    p = HttpParser()
    while True:
        header = read_head()
        if header.decode("utf-8") == "":
            return
        res = p.execute(header, len(header))
        result = None
        length_key = "content-length"
        content_length = p.get_headers()[length_key]
        if content_length != None:
            body = read_body(int(content_length))
            result = handle(body)

        out_buffer = "HTTP/1.1 200 OK\r\n"
        out_buffer += "Content-Length: "+str(len(result))+"\r\n"
        out_buffer += "\r\n"
        out_buffer += result

        sys.stdout.write(out_buffer)
        sys.stdout.flush()

def handle(body):
    return inception.invoke(body)

if __name__ == "__main__":
    main()
