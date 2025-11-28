# Web MC - Minecraft-Style Game

A Minecraft-style 3D game with multiplayer support using WebGL and Three.js. This project runs entirely in the browser and can be deployed to GitHub Pages.

## Features

- Minecraft-style block-based 3D world
- First-person movement controls (WASD + mouse look)
- Block placement and destruction
- Multiplayer support (simulated)
- Day/night cycle
- Inventory system
- Mobile-friendly controls
- Cross-platform compatibility

## Controls

### Desktop
- **WASD** or **Arrow Keys**: Move around
- **Mouse**: Look around
- **Left Click**: Break block
- **Right Click**: Place block
- **Space**: Jump
- **ESC**: Pause game

### Mobile
- On-screen controls for movement and actions
- Touch-based block interaction

## Technologies Used

- **Three.js**: 3D rendering engine
- **WebGL**: Hardware-accelerated graphics
- **HTML5/CSS3**: UI and styling
- **JavaScript**: Game logic and interactions

## Deployment

This project is designed to work with GitHub Pages:

1. Push your code to a GitHub repository
2. Enable GitHub Pages in your repository settings
3. Select the `main` branch as the source
4. Your game will be available at `https://your-username.github.io/repository-name`

## Local Development

To run the project locally:

```bash
npm install
npm start
```

Or simply open `index.html` in your browser.

## Project Structure

```
├── index.html          # Main game file
├── README.md           # This file
└── package.json        # Dependencies and scripts
```

## Browser Compatibility

- Chrome 58+
- Firefox 55+
- Safari 11+
- Edge 79+

## License

MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request