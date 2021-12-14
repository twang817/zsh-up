# zsh-up
Quickly navigate up directories by name or index.

Based on [shannonmoeller/up](https://github.com/shannonmoeller/up).

## Install

### zsh

```
zinit light "twang817/zsh-up"
```

## Usage

```
$ up [dir] [count]

   dir    string to search parent directory names; prefix with ^ to force
          pattern matching to begin at beginning of directory name.
   count  number of matches to traverse; when dir is omitted, number of
          levels to go up
```

## Examples

Up one level:

```
/home/john/workspace > up
/home/john >
```

Up multiple levels:
```
/home/john/workspace/project/spaces/home > up 3
/home/john/workspace >
```

Up by name:
```
/home/john/workspace/project/spaces/home > up workspace
/home/john/workspace >
```

Up by match:
```
/home/john/workspace/project/spaces/home > up space
/home/john/workspace/project/spaces >
```

Up by nth match:
```
/home/john/workspace/project/spaces/home > up space 2
/home/john/workspace >
```

Up by prefix match:
```
/home/john/workspace/project/spaces/home > up ^work
/home/john/workspace >
```

## Configuration

```
UP_MATCH_PREFIX=1     Always use prefix mode.
UP_ECHO_RESULT=1      Echo result directory.
```
