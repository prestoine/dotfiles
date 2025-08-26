// File: ttree/src/main.rs
use walkdir::WalkDir;
use clap::Parser;
use std::path::PathBuf;
use regex::Regex;
use std::fs::File;
use std::io::{BufReader, BufRead};

#[derive(Parser, Debug)]
#[command(version, about = "A simple tree clone in Rust")]
struct Args {
    #[arg(default_value = ".")]
    path: PathBuf,

    #[arg(short = 'a', long, help = "All files are listed (shows hidden files)")]
    all: bool,

    #[arg(short = 'I', long, value_name = "PATTERN", help = "Do not list files that match the pattern")]
    ignore_pattern: Option<String>,
}

const FOLDER_ICON: &str = "📁";
const FILE_ICON: &str = "📄";
const PIPE: &str = "│   ";
const TEE: &str = "├── ";
const ELBOW: &str = "└── ";

fn main() {
    let args = Args::parse();
    let root_path = &args.path;

    if !root_path.exists() {
        eprintln!("Error: Path '{}' not found.", root_path.display());
        return;
    }
    
    let ignore_regex = args.ignore_pattern.as_ref().and_then(|p| Regex::new(p).ok());
    
    // Print the root folder
    println!("{} {}", FOLDER_ICON, root_path.display());

    let mut it = WalkDir::new(root_path)
        .min_depth(1)
        .into_iter()
        .filter_entry(|e| {
            let file_name = e.file_name().to_string_lossy();
            let is_hidden = file_name.starts_with('.');
            let is_ignored = ignore_regex.as_ref().map_or(false, |re| re.is_match(&file_name));
            
            (!is_hidden || args.all) && !is_ignored
        })
        .peekable();

    let mut path_stack: Vec<bool> = Vec::new();
    
    while let Some(entry) = it.next() {
        let entry = match entry {
            Ok(e) => e,
            Err(_) => continue,
        };
        
        let is_last = it.peek().map_or(true, |peeked_entry| {
            let next_entry_path = peeked_entry.as_ref().ok().map(|e| e.path());
            entry.path().parent() != next_entry_path.and_then(|p| p.parent())
        });
        
        while path_stack.len() >= entry.depth() {
            path_stack.pop();
        }
        path_stack.push(is_last);

        let mut prefix = String::new();
        for i in 0..path_stack.len() - 1 {
            prefix.push_str(if path_stack[i] { "    " } else { PIPE });
        }
        
        let connector = if *path_stack.last().unwrap_or(&true) { ELBOW } else { TEE };
        
        // This is the new logic for printing line counts
        let (icon, suffix) = if entry.file_type().is_file() {
            let line_count_str = if let Ok(file) = File::open(entry.path()) {
                let reader = BufReader::new(file);
                // The `count()` method on an iterator is efficient
                let lines_count = reader.lines().count();
                format!(" ({})", lines_count)
            } else {
                " (N/A)".to_string()
            };
            (FILE_ICON, line_count_str)
        } else {
            (FOLDER_ICON, "".to_string())
        };
        
        println!("{}{}{}{} {}", prefix, connector, icon, entry.file_name().to_string_lossy(), suffix);
    }
}
