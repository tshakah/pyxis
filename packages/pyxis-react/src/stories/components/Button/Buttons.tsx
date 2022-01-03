import React, {FC} from "react";
import './Button.scss'

// TODO: replace with the component story
const Buttons: FC = () => (
  <div>
    <div className="wrapper">
      <button className="button button--light button--huge button--primary">Huge</button>
      <button className="button button--light button--large button--primary">Large</button>
      <button className="button button--light button--medium button--primary">Medium</button>
      <button className="button button--light button--small button--primary">Small</button>
    </div>
    <div className="wrapper">
      <button className="button button--light button--huge button--primary button--loading">Huge</button>
      <button className="button button--light button--large button--primary button--loading">Large</button>
      <button className="button button--light button--medium button--primary button--loading">Medium</button>
      <button className="button button--light button--small button--primary button--loading">Small</button>
    </div>
    <div className="wrapper">
      <button className="button button--light button--huge button--shadow button--primary">Huge</button>
      <button className="button button--light button--large button--shadow button--primary">Large</button>
      <button className="button button--light button--medium button--shadow button--primary">Medium</button>
      <button className="button button--light button--small button--shadow button--primary">Small</button>
    </div>
    <div className="wrapper">
      <button disabled className="button button--light button--huge button--primary">Huge</button>
      <button disabled className="button button--light button--large button--primary">Large</button>
      <button disabled className="button button--light button--medium button--primary">Medium</button>
      <button disabled className="button button--light button--small button--primary">Small</button>
    </div>
    <div className="wrapper">
      <button className="button button--light button--huge button--primary button--content–width">Huge</button>
      <button className="button button--light button--large button--primary button--content–width">Large</button>
      <button className="button button--light button--medium button--primary button--content–width">Medium</button>
      <button className="button button--light button--small button--primary button--content–width">Small</button>
    </div>

    <div className="wrapper">
      <button className="button button--light button--large button--brand">Large</button>
      <button className="button button--light button--medium button--brand">Medium</button>
      <button className="button button--light button--small button--brand">Small</button>
    </div>
    <div className="wrapper">
      <button className="button button--light button--large button--brand button--loading">Large</button>
      <button className="button button--light button--medium button--brand button--loading">Medium</button>
      <button className="button button--light button--small button--brand button--loading">Small</button>
    </div>
    <div className="wrapper">
      <button className="button button--light button--large button--shadow button--brand">Large</button>
      <button className="button button--light button--medium button--shadow button--brand">Medium</button>
      <button className="button button--light button--small button--shadow button--brand">Small</button>
    </div>
    <div className="wrapper">
      <button disabled className="button button--light button--large button--brand">Large</button>
      <button disabled className="button button--light button--medium button--brand">Medium</button>
      <button disabled className="button button--light button--small button--brand">Small</button>
    </div>
    <div className="wrapper">
      <button className="button button--light button--large button--brand button--content–width">Large</button>
      <button className="button button--light button--medium button--brand button--content–width">Medium</button>
      <button className="button button--light button--small button--brand button--content–width">Small</button>
    </div>

    <div className="wrapper">
      <button className="button button--light button--large button--secondary">Large</button>
      <button className="button button--light button--medium button--secondary">Medium</button>
      <button className="button button--light button--small button--secondary">Small</button>
    </div>
    <div className="wrapper">
      <button className="button button--light button--large button--secondary button--loading">Large</button>
      <button className="button button--light button--medium button--secondary button--loading">Medium</button>
      <button className="button button--light button--small button--secondary button--loading">Small</button>
    </div>

    <div className="wrapper">
      <button disabled className="button button--light button--large button--secondary">Large</button>
      <button disabled className="button button--light button--medium button--secondary">Medium</button>
      <button disabled className="button button--light button--small button--secondary">Small</button>
    </div>
    <div className="wrapper">
      <button className="button button--light button--large button--secondary button--content–width">Large</button>
      <button className="button button--light button--medium button--secondary button--content–width">Medium</button>
      <button className="button button--light button--small button--secondary button--content–width">Small</button>
    </div>

    <div className="wrapper">
      <button className="button button--light button--large button--tertiary">Large</button>
      <button className="button button--light button--medium button--tertiary">Medium</button>
      <button className="button button--light button--small button--tertiary">Small</button>
    </div>
    <div className="wrapper">
      <button className="button button--light button--large button--tertiary button--loading">Large</button>
      <button className="button button--light button--medium button--tertiary button--loading">Medium</button>
      <button className="button button--light button--small button--tertiary button--loading">Small</button>
    </div>
    <div className="wrapper">
      <button disabled className="button button--light button--large button--tertiary">Large</button>
      <button disabled className="button button--light button--medium button--tertiary">Medium</button>
      <button disabled className="button button--light button--small button--tertiary">Small</button>
    </div>
    <div className="wrapper">
      <button className="button button--light button--large button--tertiary button--content–width">Large</button>
      <button className="button button--light button--medium button--tertiary button--content–width">Medium</button>
      <button className="button button--light button--small button--tertiary button--content–width">Small</button>
    </div>

    <div className="wrapper">
      <button className="button button--light button--large button--ghost">Large</button>
      <button className="button button--light button--medium button--ghost">Medium</button>
      <button className="button button--light button--small button--ghost">Small</button>
    </div>

    <div className="wrapper">
      <button disabled className="button button--light button--large button--ghost">Large</button>
      <button disabled className="button button--light button--medium button--ghost">Medium</button>
      <button disabled className="button button--light button--small button--ghost">Small</button>
    </div>

    <div className="wrapper">
      <button className="button button--light button--huge button--trailing-icon button--primary">
        Huge
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
      </button>
      <button className="button button--light button--large button--trailing-icon button--primary">
        Large
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
      </button>
      <button className="button button--light button--medium button--trailing-icon button--primary">
        Medium
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
      </button>
      <button className="button button--light button--small button--trailing-icon button--primary">
        Small
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
      </button>
    </div>

    <div className="wrapper">
      <button className="button button--light button--huge button--leading-icon button--primary">
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
        Huge
      </button>
      <button className="button button--light button--large button--leading-icon button--primary">
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
        Large
      </button>
      <button className="button button--light button--medium button--leading-icon button--primary">
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
        Medium
      </button>
      <button className="button button--light button--small button--leading-icon button--primary">
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
        Small
      </button>
    </div>

    <div className="wrapper">
      <button className="button button--light button--huge button--icon-only button--primary">
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
      </button>
      <button className="button button--light button--large button--icon-only button--primary">
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
      </button>
      <button className="button button--light button--medium button--icon-only button--primary">
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
      </button>
    </div>

    <div className="wrapper">
      <button className="button button--light button--large button--icon-only button--tertiary">
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
      </button>
      <button className="button button--light button--medium button--icon-only button--tertiary">
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
      </button>
    </div>

    <div className="wrapper">
      <button className="button button--light button--large button--icon-only button--ghost">
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
      </button>
      <button className="button button--light button--medium button--icon-only button--ghost">
        <div className="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/></svg>
        </div>
      </button>
    </div>
  </div>
)

export default Buttons;