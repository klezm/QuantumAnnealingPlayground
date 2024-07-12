import itertools
from pathlib import Path

def get_markdown_files(root_dir):
    return sorted([p.relative_to(root_dir) for p in root_dir.glob("**/*.md")])

def get_html_files_and_dirs(pages_root):
    html_files = list(pages_root.glob("**/*.html"))
    html_dirs = list(set([x.parent for x in html_files]))
    return sorted(html_files + html_dirs)

def get_html_files_and_dirs_grouped(pages_root):
    html_files = sorted(pages_root.glob("**/*.html"))
    html_tree = sorted([g, sorted(fs)] for g, fs in itertools.groupby(html_files, key=lambda x: x.parent))
    return html_tree

def make_md_link(url, text=None, list=False, indent=0):
    return ("\t" * indent) + ("- " if (list | indent) else "") + f"[{text or url}]({url})"

def make_md_link_list(
        urls,
        level=0,
        root=Path("."),
        remove_suffix="",
        replace_url_suffix={"README.md": "index.html"},
        orig_suffix=False,
        ):
    links = []
    for url in urls:
        text = None
        if remove_suffix:
            text = url.name.removesuffix(remove_suffix)
        if orig_suffix:
            for p in url.parent.glob(f'{url.stem}.*'):
                if url.suffix != p.suffix:
                    text = p.name  # p.relative_to(base_dir).name
        if replace_url_suffix and url.name.lower() in [x.lower() for x in replace_url_suffix]:
            # text = text or url.name
            text = url.relative_to(root).as_posix()
            url = url.relative_to(root).with_name(replace_url_suffix[url.name])
            # url = url.parent
        links.append(make_md_link(url.relative_to(root), text=text, list=True, indent=level))
    return "\n".join(links)
    return "\n".join(make_md_link(
        url,
        text=None if not remove_suffix else url.name.removesuffix(remove_suffix),
        list=True,
        indent=level) for url in urls)

def _generate_md_file_tree(dirs, pages_root=Path("."), remove_suffix=".html"):
    links = []
    for item in sorted(dirs):
        if item.is_dir():
            links.append(f'- {item.relative_to(pages_root).as_posix()}')
        else:
            link_text = item.relative_to(item.parent).name.removesuffix(remove_suffix)
            links.append(make_md_link(item.relative_to(pages_root), link_text, indent=1))
    return "\n".join(links)

def generate_md_file_tree(dirs, pages_root=Path("."), remove_suffix=".html"):
    links = []
    for parent, files in dirs:
        links.append(f'- {parent.relative_to(pages_root).as_posix()}')
        links.append(make_md_link_list(files, level=1, root=pages_root, remove_suffix=remove_suffix, orig_suffix=True))
    return "\n".join(links)

def update_readme_with_links(root_dir):
    md_files = get_markdown_files(root_dir)
    # html_items = get_html_files_and_dirs(root_dir)
    html_items = get_html_files_and_dirs_grouped(root_dir)
    with open(root_dir.joinpath("README.md"), "a+") as f:
        f.write("\n## Sitemap Markdowns\n\n")
        f.write(make_md_link_list(md_files))
        f.write("\n\n## Sitemap HTMLs\n\n")
        f.write(generate_md_file_tree(html_items, pages_root=root_dir))
    # md = "\n## Sitemap Markdowns\n\n"
    # md += make_md_link_list(md_files)
    # md += "\n\n## Sitemap HTMLs\n\n"
    # md += generate_md_file_tree(html_items, pages_root=root_dir)
    # return md

def insert_toc_in_readmes(root_dir):
    for readme in root_dir.glob("**/README.md"):
        update_readme_with_links(readme.parent)
        # display(Markdown(update_readme_with_links(readme.parent)))

pages_root = Path(".")
# update_readme_with_links(pages_root)
# from IPython.display import Markdown, HTML
# display(Markdown(update_readme_with_links(pages_root)))
insert_toc_in_readmes(pages_root)
