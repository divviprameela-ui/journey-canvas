import 'package:flutter/material.dart';

class SkillModel {
  final String name;
  final String proficiencyTag; // e.g. 'Full-Stack UI Specialist', 'Advanced Fluency'
  final IconData icon;
  final Color color;
  final String category;
  final String summary;
  final List<String> coreLearnings;
  final List<String> projectsBuilt;
  final List<String> topics;
  final String keyTakeaway;

  const SkillModel({
    required this.name,
    required this.proficiencyTag,
    required this.icon,
    required this.color,
    required this.category,
    required this.summary,
    required this.coreLearnings,
    required this.projectsBuilt,
    required this.topics,
    required this.keyTakeaway,
  });

  static List<SkillModel> get allSkills => [
        // Frameworks & Mobile/Web
        const SkillModel(
          name: 'Flutter & Dart',
          proficiencyTag: 'Full-Stack UI Specialist',
          icon: Icons.flutter_dash,
          color: Color(0xFF6366F1),
          category: 'Frameworks & UI',
          summary:
              'Cross-platform UI development with fluid 60fps animations, reactive state management, and modern glassmorphic architecture.',
          topics: ['Widgets Lifecycle', 'Animations & Canvas', 'State Mgmt', 'Web Deployment'],
          coreLearnings: [
            'Built responsive layouts using CustomPainter, LayoutBuilder, and MediaQuery',
            'Mastered AnimationControllers, CurvedAnimations, and 3D matrix transformations',
            'Implemented clean architecture with modular component hierarchy',
            'Mastered state synchronization, hot reload optimization, and Flutter Web rendering',
          ],
          projectsBuilt: [
            'JourneyCanvas — Futuristic Glassmorphic Portfolio Web App',
            'Responsive Interactive Dashboard with fluid animations',
          ],
          keyTakeaway:
              'Flutter enables me to translate complex visual concepts into seamless cross-platform reality with pixel-perfect precision.',
        ),
        // Programming Languages
        const SkillModel(
          name: 'Python',
          proficiencyTag: 'Advanced Fluency',
          icon: Icons.code,
          color: Color(0xFF3B82F6),
          category: 'Programming Languages',
          summary:
              'Object-oriented programming, data structures, scripting, and backend algorithmic problem-solving.',
          topics: ['OOP Patterns', 'Data Structures', 'File Handling', 'AI / ML Basics'],
          coreLearnings: [
            'Mastered object-oriented design patterns, inheritance, and clean code principles',
            'Implemented fundamental algorithms (searching, sorting, graph traversals, dynamic programming)',
            'Explored Python ecosystem for automation, data parsing, and RESTful API consumption',
            'Hands-on experience with NumPy and foundational machine learning concepts',
          ],
          projectsBuilt: [
            'Algorithmic Problem Solvers & Utility Scripts',
            'Data Analysis and Automated File Processors',
          ],
          keyTakeaway:
              'Python is my go-to weapon for rapid prototyping, algorithmic thinking, and bridging software with AI.',
        ),
        const SkillModel(
          name: 'Java',
          proficiencyTag: 'Enterprise OOP',
          icon: Icons.coffee,
          color: Color(0xFFEC4899),
          category: 'Programming Languages',
          summary:
              'Robust OOP engineering, memory management concepts, multithreading, and collections framework.',
          topics: ['Collections API', 'Multithreading', 'Generics', 'Exception Handling'],
          coreLearnings: [
            'Deep dive into Java Collections Framework (List, Set, Map, Queue implementations)',
            'Mastered Exception handling architectures, input/output streams, and generics',
            'Understood JVM internals, memory lifecycle, and garbage collection paradigms',
            'Applied SOLID principles in building modular object architectures',
          ],
          projectsBuilt: [
            'Student Management & Academic Tracking System',
            'Object-Oriented Banking Simulation Engine',
          ],
          keyTakeaway:
              'Java taught me rigorous software engineering discipline, type safety, and large-scale architectural clarity.',
        ),
        const SkillModel(
          name: 'C / C++',
          proficiencyTag: 'Systems & Algorithms',
          icon: Icons.terminal,
          color: Color(0xFF10B981),
          category: 'Programming Languages',
          summary:
              'Low-level systems programming, pointer arithmetic, memory allocation, and high-performance algorithms.',
          topics: ['Pointers & Memory', 'Data Structures', 'Complexity Analysis', 'STL'],
          coreLearnings: [
            'Direct memory management using malloc/free and new/delete pointers',
            'Built custom data structures from scratch: Linked Lists, Binary Trees, Stacks, & Queues',
            'Mastered C++ Standard Template Library (STL: vectors, iterators, algorithms)',
            'Optimized time and space complexities for performance-critical tasks',
          ],
          projectsBuilt: [
            'Custom In-Memory Data Structure Library',
            'High-Performance Graph Pathfinding Algorithms',
          ],
          keyTakeaway:
              'Understanding C/C++ provides deep insight into how computers actually execute instructions under the hood.',
        ),
        const SkillModel(
          name: 'HTML5 & CSS3',
          proficiencyTag: 'Modern Web Styling',
          icon: Icons.web,
          color: Color(0xFFF59E0B),
          category: 'Web Technologies',
          summary:
              'Semantic markup, responsive modern CSS, flexbox/grid architectures, and interactive glassmorphic styling.',
          topics: ['Semantic HTML', 'Flexbox & CSS Grid', 'Keyframes & Motion', 'Glassmorphism'],
          coreLearnings: [
            'Designed pixel-perfect responsive layouts with modern CSS Grid and Flexbox',
            'Created engaging micro-interactions, gradients, blur filters, and transitions',
            'Followed web accessibility (a11y) and SEO semantic standards',
            'Implemented dark mode color schemes and modern design token systems',
          ],
          projectsBuilt: [
            'Interactive Showcase Web Pages',
            'Modern Glassmorphic UI Components & Landing Pages',
          ],
          keyTakeaway:
              'Web design is where logic meets artistry; CSS gives life and personality to functional software.',
        ),
        // Tools & Data
        const SkillModel(
          name: 'Git & GitHub',
          proficiencyTag: 'Collaborative DevOps',
          icon: Icons.account_tree,
          color: Color(0xFF8B5CF6),
          category: 'Developer Tools',
          summary:
              'Version control mastery, branching workflows, pull requests, merge conflict resolution, and open source hygiene.',
          topics: ['Branching Strategies', 'PR Workflows', 'Merge Conflicts', 'CI/CD Basics'],
          coreLearnings: [
            'Proficient in Git CLI: branching, stashing, rebasing, and cherry-picking',
            'Maintained clean commit histories, semantic versioning, and meaningful PR descriptions',
            'Resolved complex multi-developer merge conflicts seamlessly',
            'Configured GitHub repositories with issues, project boards, and automation workflows',
          ],
          projectsBuilt: [
            'Multi-branch open-source collaborative codebases',
            'Automated documentation and portfolio deployments',
          ],
          keyTakeaway:
              'Version control is the bedrock of dependable teamwork and fearless iterative development.',
        ),
        const SkillModel(
          name: 'SQL & Relational DBs',
          proficiencyTag: 'Data Modeling Specialist',
          icon: Icons.storage,
          color: Color(0xFF06B6D4),
          category: 'Developer Tools',
          summary:
              'Relational schema design, normalization, complex multi-table joins, indexing, and transactional integrity.',
          topics: ['Schema Design', 'JOIN Operations', 'Normalization (3NF)', 'Indexing & Subqueries'],
          coreLearnings: [
            'Designed normalized relational schemas minimizing redundancy and anomalies',
            'Authored complex queries utilizing INNER/OUTER JOINs, GROUP BY, HAVING, and aggregate functions',
            'Implemented subqueries, views, constraints, and ACID-compliant transactions',
            'Analyzed query execution plans to identify indexing and performance bottlenecks',
          ],
          projectsBuilt: [
            'University Database Schema with multi-entity relationships',
            'Inventory & E-commerce transaction querying model',
          ],
          keyTakeaway:
              'Data integrity and structured query design are essential for building reliable, production-grade applications.',
        ),
        const SkillModel(
          name: 'VS Code & Tooling',
          proficiencyTag: 'Productivity Architect',
          icon: Icons.developer_mode,
          color: Color(0xFF0EA5E9),
          category: 'Developer Tools',
          summary:
              'Supercharged developer environment, keyboard shortcuts, linting rules, debugging tools, and extensions.',
          topics: ['IDE Debugging', 'Flutter DevTools', 'Task Automation', 'Workspace Config'],
          coreLearnings: [
            'Configured advanced debugging with breakpoints, call stacks, and expression watchers',
            'Set up automated linting, code formatting, and Git lens integration',
            'Mastered Flutter DevTools for memory profiling, widget inspector, and network tracing',
            'Streamlined daily engineering velocity with custom snippets and keyboard shortcuts',
          ],
          projectsBuilt: [
            'Customized full-stack development workspace setup',
            'Optimized build configurations for web and mobile development',
          ],
          keyTakeaway:
              'A finely tuned development environment removes friction and lets creative engineering flow freely.',
        ),
      ];
}
