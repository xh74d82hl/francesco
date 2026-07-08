from mcp.server import FastMCP
from pathlib import Path
import os

mcp = FastMCP("docling")

def _cache_path(source: str) -> Path | None:
    p = Path(source)
    if not p.is_absolute() or not p.exists():
        return None
    return p.with_name(p.name + ".docling.md")

def _read_cache(cache: Path) -> str | None:
    if not cache.exists():
        return None
    src = cache.with_suffix("")
    if src.exists() and cache.stat().st_mtime >= src.stat().st_mtime:
        return cache.read_text(encoding="utf-8")
    return None

def _write_cache(cache: Path, md: str):
    cache.write_text(md, encoding="utf-8")

def _convert(source: str) -> str:
    from docling.document_converter import DocumentConverter
    converter = DocumentConverter()
    result = converter.convert(source)
    return result.document.export_to_markdown()

@mcp.tool()
def convert_to_markdown(source: str) -> str:
    """Convert PDF, DOCX, PPTX, XLSX, image (scanned or native) to clean Markdown.
    Supports OCR for scanned documents automatically.
    Accepts local file paths or URLs.
    Caches result to <source>.docling.md when source is a local file.
    """
    cache = _cache_path(source)
    if cache:
        cached = _read_cache(cache)
        if cached is not None:
            return cached
    md = _convert(source)
    if cache:
        _write_cache(cache, md)
    return md

@mcp.tool()
def convert_batch(sources: list[str]) -> str:
    """Convert multiple documents to Markdown.
    Accepts a list of file paths or URLs.
    Returns concatenated markdown with source headers.
    Each source is cached individually.
    """
    outputs = []
    for src in sources:
        cache = _cache_path(src)
        if cache:
            cached = _read_cache(cache)
            if cached is not None:
                outputs.append(f"## Source: {src}\n\n{cached}")
                continue
        md = _convert(src)
        if cache:
            _write_cache(cache, md)
        outputs.append(f"## Source: {src}\n\n{md}")
    return "\n\n---\n\n".join(outputs)

if __name__ == "__main__":
    mcp.run()
