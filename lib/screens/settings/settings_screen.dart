import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.userProfile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileSection(context, user?.displayName, user?.email),
            const Divider(),
            _buildNotificationSettings(context),
            const Divider(),
            _buildAccountSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(
    BuildContext context,
    String? displayName,
    String? email,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              displayName?.substring(0, 1).toUpperCase() ?? 'U',
              style: const TextStyle(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            displayName ?? 'User',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            email ?? '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, _) {
        return SwitchListTile(
          title: const Text('Location-based Notifications'),
          subtitle: const Text('Receive notifications about nearby services'),
          value: provider.locationNotificationsEnabled,
          onChanged: (value) {
            provider.toggleLocationNotifications(value);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  value
                      ? 'Location notifications enabled'
                      : 'Location notifications disabled',
                ),
                backgroundColor: Colors.green,
              ),
            );
          },
          secondary: const Icon(Icons.notifications_active),
        );
      },
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          subtitle: const Text('Kigali Services Directory v1.0.0'),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'Kigali Services Directory',
              applicationVersion: '1.0.0',
              applicationIcon: const Icon(Icons.location_city, size: 48),
              children: [
                const Text(
                  'A mobile application to help Kigali residents locate and navigate to essential public services and places.',
                ),
              ],
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text(
            'Sign Out',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Sign Out'),
                content: const Text('Are you sure you want to sign out?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );

            if (confirmed == true && context.mounted) {
              await Provider.of<AuthProvider>(context, listen: false).signOut();
            }
          },
        ),
      ],
    );
  }
}
