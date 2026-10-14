# WezTerm

現在は2026年1月17日版を `~/Applications/WezTerm.app` にインストールしています。
`~/.zshrc` の `wezterm` エイリアスで、このアプリの CLI と専用設定を呼び出します。

Ghostty からターミナル部分を移行し、ペイン・セッション・コピーモードは tmux を使います。
起動時のシェルは WezTerm の既定設定を使います。tmux への接続は手動です。

## インストールと設定

```sh
brew install --cask font-noto-sans-jp
mkdir -p ~/.config
ln -s ~/dotfiles/wezterm/.config/wezterm ~/.config/wezterm
```

GNU Stow を使う場合は、dotfiles ディレクトリで `stow wezterm` でも配置できます。
設定リンクがすでに存在する場合は、上のリンク作成を省略してください。
英数字は Menlo、日本語は Noto Sans JP です。`~/Library/Fonts` を直接検索する設定も追加しています。
アプリ本体は下記の公式コミットからビルドした1月版です。

## 起動と操作

アプリケーションフォルダの WezTerm を起動し、必要な tmux セッションに接続します。
tmux 接続中のタブ名はセッション名です。セッションを切り替えるとタブ名も更新されます。

| キー | 操作 |
| --- | --- |
| Command + `[` / `]` | tmux の前 / 次のペイン |
| Command + T | WezTerm の新しいタブ |
| Control + Tab / Control + Shift + Tab | 次 / 前のタブ |
| Command + Shift + `[` / `]` | 前 / 次のタブ |
| Command + 1〜8 / 9 | 指定のタブ / 最後のタブ |
| Command + W | タブを閉じる（実行中のプロセスがあれば確認） |
| Command + C / V | コピー / 貼り付け |
| Command + `+` / `-` / 0 | 文字サイズ拡大 / 縮小 / リセット |
| Command + Shift + `,` | 設定再読み込み |

tmux の分割、移動、プレフィックス、vi コピーモードの設定は従来のままです。
提示コードに合わせて WezTerm の Leader は Control + Q（待機時間 2 秒）です。
WezTerm の分割・ワークスペース・コピーモードのショートカットは設定していません。
tmux は WezTerm の `xterm-256color` を拡張キーと RGB 色に対応する端末として扱います。

## 外観

背景透過 0.85、ぼかし 20、タイトルバー非表示、斜めのタブ装飾と黄色のアクティブタブを採用しています。
`wezterm.lua` はユーザーが提示した記事のコードを基本に、Noto Sans JP のフォント設定を追加しています。
`window_frame` の背景は `none`、全画面の背景グラデーションは黒（`#000000`）です。
タブの閉じるボタンを非表示にしています。
閉じるボタンの非表示には nightly 版が必要です。
本文の配色と合字は WezTerm の既定設定、英数字は Menlo、日本語は Noto Sans JP、文字サイズは 12pt です。

参考: https://zenn.dev/mozumasu/articles/mozumasu-wezterm-customization

Ghostty のアプリと設定は残しているため、必要なら元の環境で起動できます。

## インストールした2026年1月版

`~/Applications/WezTerm.app` は公式コミット
`05343b387085842b434d267f91b6b0ec157e4331`（2026年1月17日）からビルドしたアプリです。
公式配布の署名済み Universal バイナリではなく、この Mac 向けの Apple Silicon ビルドです。

```sh
open ~/Applications/WezTerm.app
```

`wezterm-20260117.lua` を使い、共有設定を読み込んだうえで背景グラデーションを無効にします。
これにより、本文のぼかしを維持したままタブ周辺を透明にする設定を使います。
通常の WezTerm の名前とアプリ識別子で起動します。
エイリアスを現在のシェルにも反映するには `source ~/.zshrc` を実行してください。
ソースとビルド成果物は `~/.local/share/wezterm-builds/20260117/source` にあります。
