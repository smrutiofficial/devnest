class Task {
  final String name;
  final String command;
  final String description;

  Task({
    required this.name,
    required this.command,
    required this.description,
  });
}

// List of tasks
final List<Task> tasks = [
  Task(
    name: 'System Update',
    command: 'sudo apt update && sudo apt upgrade',
    description: 'Updates all packages to their latest versions.',
  ),
  Task(
    name: 'APT Apps Install',
    command: 'sudo apt install <app-name>',
    description: 'Installs applications using the APT package manager.',
  ),
  Task(
    name: 'Flatpak Setup',
    command: 'sudo apt install flatpak',
    description: 'Installs Flatpak to manage apps across Linux distros.',
  ),
  Task(
    name: 'Install Flatpak Apps',
    command: 'flatpak install <app-name>',
    description: 'Installs applications via Flatpak.',
  ),
  Task(
    name: 'Install .DEB Apps',
    command: 'sudo dpkg -i <package-name>.deb',
    description: 'Installs .deb packages using dpkg.',
  ),
  Task(
    name: 'Remove Snap',
    command: 'sudo apt purge snapd',
    description: 'Removes the Snap package manager from your system.',
  ),
  Task(
    name: 'Setup Neovim',
    command: 'sudo apt install neovim',
    description: 'Installs Neovim, a modern text editor.',
  ),
  Task(
    name: 'Setup Tmux',
    command: 'sudo apt install tmux',
    description: 'Installs Tmux, a terminal multiplexer.',
  ),
  Task(
    name: 'Install Flutter',
    command: 'sudo snap install flutter --classic',
    description: 'Installs Flutter SDK for mobile app development.',
  ),
  Task(
    name: 'Install Android SDK',
    command: 'sudo apt install android-sdk',
    description: 'Installs the Android SDK for development.',
  ),
  Task(
    name: 'Setup Git SSH',
    command: 'ssh-keygen -t rsa -b 4096 -C "your_email@example.com"',
    description: 'Generates an SSH key pair for GitHub or other Git servers.',
  ),
  Task(
    name: 'Adding Git Alias',
    command: 'git config --global alias.<alias-name> <git-command>',
    description: 'Adds a custom alias for Git commands.',
  ),
];
