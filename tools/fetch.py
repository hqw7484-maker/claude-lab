"""fetch <url> — grab a web page and print its text content"""
import sys, re, html, urllib.request, urllib.error

def fetch(url: str, max_chars: int = 8000):
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
        with urllib.request.urlopen(req, timeout=15) as resp:
            raw = resp.read().decode(errors="replace")
            # strip tags
            text = html.unescape(re.sub(r"<script[^>]*>.*?</script>", "", raw, flags=re.S))
            text = html.unescape(re.sub(r"<style[^>]*>.*?</style>", "", text, flags=re.S))
            text = re.sub(r"<[^>]+>", " ", text)
            text = re.sub(r"\s+", " ", text).strip()
            if len(text) > max_chars:
                text = text[:max_chars] + f"\n\n[... truncated at {max_chars} chars]"
            return text
    except Exception as e:
        return f"[ERROR] {e}"

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python tools/fetch.py <url>")
        sys.exit(1)
    print(fetch(sys.argv[1]))
