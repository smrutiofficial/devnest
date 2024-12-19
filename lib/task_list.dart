class Task {
  final String title;
  final String command;
  final String description;

  Task({
    required this.title,
    required this.command,
    required this.description,
  });
}

// List of tasks
final List<Task> tasks = [
  Task(
    title: 'System Update',
    command: 'sudo apt update && sudo apt upgrade',
    description: 'Updates all packages to their latest versions.',
  ),
  Task(
    title: 'APT Apps Install',
    command: 'sudo apt install <app-name>',
    description: 'Installs applications using the APT package manager.',
  ),
  Task(
    title: 'Flatpak Setup',
    command: 'sudo apt install flatpak',
    description: 'Installs Flatpak to manage apps across Linux distros.',
  ),
  Task(
    title: 'Install Flatpak Apps',
    command: 'flatpak install <app-name>',
    description: 'Installs applications via Flatpak.',
  ),
  Task(
    title: 'Install .DEB Apps',
    command: 'sudo dpkg -i <package-name>.deb',
    description: 'Installs .deb packages using dpkg.',
  ),
  Task(
    title: 'Remove Snap',
    command: 'sudo apt purge snapd',
    description: 'Removes the Snap package manager from your system.',
  ),
  Task(
    title: 'Setup Neovim',
    command: 'sudo apt install neovim',
    description: 'Installs Neovim, a modern text editor.',
  ),
  Task(
    title: 'Setup Tmux',
    command: 'sudo apt install tmux',
    description: 'Installs Tmux, a terminal multiplexer.',
  ),
  Task(
    title: 'Install Flutter',
    command: 'sudo snap install flutter --classic',
    description: 'Installs Flutter SDK for mobile app development.',
  ),
  Task(
    title: 'Install Android SDK',
    command: 'sudo apt install android-sdk',
    description: 'Installs the Android SDK for development.',
  ),
  Task(
    title: 'Setup Git SSH',
    command: 'ssh-keygen -t rsa -b 4096 -C "your_email@example.com"',
    description: 'Generates an SSH key pair for GitHub or other Git servers.',
  ),
  Task(
    title: 'Adding Git Alias',
    command: 'git config --global alias.<alias-name> <git-command>',
    description: 'Adds a custom alias for Git commands.',
  ),
];
